# TODO: 
# when no cache, do nothing
# when cache list >= 50, evict the oldest tweet
# if the fanout helper is on Tweetservice, we need to pass in followers' ids array
# fanout including username, or denormalize Tweet

def fanout_helper(user_id, tweet)
  return unless $timeline_redis.cached? user_id

  followers_ids = get_followers_ids user_id
  followers_ids.each do |f_id|
    $timeline_redis.push_single(f_id, tweet)
  end
end