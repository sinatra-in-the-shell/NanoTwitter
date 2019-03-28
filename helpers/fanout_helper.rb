def fanout_helper(user, tweet)
  redis_client = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
  
  user_id = user.id
  tweet_id = tweet.id
  followers = user.followers
  
  pp '**** User with id = ', user_id, 'followers are: ****'
  pp followers
  pp '**** followers over ****'

  followers.each do |f|
    redis_client.lpush(f.id, tweet.to_json)
    top = JSON.parse(redis_client.lrange(f.id, 0, 0).first)
    pp '*** TOP ITEM IN REDIS CACHE OF USER_ID #{f.id} IS ***'
    pp top
  end

end 