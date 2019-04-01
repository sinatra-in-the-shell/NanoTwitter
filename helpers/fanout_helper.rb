def fanout_helper(user, tweet)
  redis_client = RedisClient.new(ENV['REDIS_URL'] || 'redis://localhost:6379')
  user_id = user.id
  followers = user.followers
  followers.each do |f|
    redis_client.push_single(f.id, tweet)
  end
end 