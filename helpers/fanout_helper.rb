def get_followers(user_id)
  if $followers_redis&.cached? user_id
    followers = $followers_redis.get_json_list(user_id, 0, -1)
  else
    followers = User.find(user_id).followers
    $followers_redis&.push_results(user_id, followers)
    followers.map{|i| JSON.parse i.to_json}
  end
end

def fanout_helper(user_id, tweet)
  #insert into timeline redis
  followers_ids = get_followers(user_id).map{|i| i["id"]}
  return if followers_ids.nil?

  followers_ids.each do |f_id|
    if $timeline_redis.cached?(f_id)
      $timeline_redis.push_single(f_id, tweet)
      if $timeline_redis.length(f_id) > 50
        $timeline_redis.pop_single(f_id)
      end
    end
  end
end
