# TODO: 
# when no cache, do nothing
# when cache list >= 50, evict the oldest tweet
# if the fanout helper is on Tweetservice, we need to pass in followers' ids array

def fanout_helper(user, tweet)
  user_id = user.id
  followers = user.followers
  followers.each do |f|
    $timeline_redis.push_single(f.id, tweet)
  end
end