require 'redis'
require 'json'


class RedisClient

  def initialize(redis_url)
    @redis_client = Redis.new(url: redis_url)
  end

  def cached?(key)
    @redis_client.exists(key)
  end

  def get_json_list(key, lrange, rrange)
    cached = @redis_client.lrange(key, lrange, rrange)
    json_array = []
    cached.each do |c|
      json_array << JSON.parse(c)
    end
    json_array
  end

  def push_results(key, db_results)
    db_results.each do |r|
      @redis_client.lpush(key, r.to_json)
    end
  end

  def push_single(key, result)
    @redis_client.lpush(key, result.to_json)
  end
end