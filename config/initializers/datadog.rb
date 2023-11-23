Datadog.configure do |c|
  c.service = "test-service"
  c.env = "development"
  c.logger.instance = Logger.new($stdout)
  c.runtime_metrics.enabled = true
  c.diagnostics.debug = true
end

$redis = Redis.new
Datadog.configure do |c|
  c.tracing.instrument :redis
end
$redis_2 = Redis.new

# This configure_onto doesn't work; interactions with this redis instance will
# be reported with default "redis" service name and "command_args" false.
# This happens because this redis instance was initialized before Datadog redis
# instrumentation was configured.
Datadog.configure_onto($redis, service_name: "my-custom-redis", command_args: true)


# This configure_onto works fine, as it was initialized after Datadog redis
# instrumentation was configured.
Datadog.configure_onto($redis_2, service_name: "my-other-redis", command_args: true)
