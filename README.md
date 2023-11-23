# Reproducing unexpected `Datadog.configure_onto` behaviour on Redis instance

Issue: DataDog/dd-trace-rb#3277

This repository aims to reproduce an issue with `Datadog.configure_onto` when
it is used with a Redis instance that was initialized before the Datadog redis
tracing is configured.
When that happens, the `configure_onto` will actually have no effect.

To reproduce:  
- run the server (`bundle exec rails s`)
- make a request to `/test` (`curl localhost:3000/test`
- observe on the server terminal that spans for the `$redis` instance have the
default `"redis"` service name, while spans for the `$redis_2` instance have
the custom `"my-other-redis"` service name.

