def fanout_helper(user, tweet)
  user_id = user.id
  followers = user.followers
  followers.each do |f|
    $timeline_redis.push_single(f.id, tweet)
  end
end 