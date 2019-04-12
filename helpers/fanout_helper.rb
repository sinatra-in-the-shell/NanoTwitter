def fanout_helper(user_id, tweet)
  followers_ids = get_followers_ids(user_id)
  return if followers_ids.nil?
  followers_ids.each do |f_id|
    if $timeline_redis.cached?(f_id)
      $timeline_redis.push_single(f_id, tweet)
      if $timeline_redis.length(f_id)
        $timeline_redis.pop_single(f_id)
      end
    end
  end
end