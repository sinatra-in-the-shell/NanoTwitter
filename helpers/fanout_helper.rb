def fanout_helper(user, tweet)
  redis_client = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
  
  user_id = user.id
  tweet_id = tweet.id
  followers = user.followers

  followers.each do |f|
    redis_client.lpush(f.id, tweet.to_json)
  end

end 