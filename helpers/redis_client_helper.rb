require 'redis'
require 'json'

class RedisClient

  def initialize(redis_url)
    @redis_client = Redis.new(url: redis_url)
  end

  def cached?(key)
    @redis_client.exists(key)
  end

  def length(key)
    @redis_client.llen(key)
  end

  def get_list(key, lrange, rrange)
    @redis_client.get(key)
  end

  def get_json_list(key, lrange, rrange)
    JSON.parse @redis_client.get(key)
  end

  def push_results(key, db_results)
    @redis_client.set(key, db_results.to_json)
  end

  def push_single(key, result)
    @redis_client.lpush(key, result.to_json)
  end

  def pop_single(key)
    @redis_client.rpop(key)
  end

  def del(key)
    @redis_client.del(key)
  end

  def clear
    @redis_client.flushall
  end
end
