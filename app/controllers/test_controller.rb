class TestController < ApplicationController
  def index
    $redis.get("test_get")
    $redis.set("test_set", "abc")
    $redis.pipelined do |pipe|
      pipe.get("test_pipe_get")
      pipe.set("test_pipe_set", "abc")
    end

    $redis_2.get("redis_2-get")
    $redis_2.set("redis_2-set", "abc")
    $redis_2.pipelined do |pipe|
      pipe.get("redis_2-pipe_get")
      pipe.set("redis_2-pipe_set", "abc")
    end

    render plain: "OK"
  end
end
