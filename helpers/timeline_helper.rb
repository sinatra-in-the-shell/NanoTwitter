# get leaders ids from redis and then get leaders tweet, then sort
def get_timeline(user_id, limit)
  leaders = get_leaders(user_id)
  return [] if leaders.nil?
  leaders_ids = leaders.map {|l| l["id"]}
  leaders_tweets = Tweet.where(user_id: leaders_ids).limit(limit)
  sorted = leaders_tweets.sort_by { |t| t[:created_at] }.reverse!
end

def get_leaders(user_id)
  if $leaders_redis.cached? user_id
    leaders = $leaders_redis.get_json_list(user_id, 0, -1)
  else
    leaders = User.find(user_id).followings
    $leaders_redis.push_results(user_id, leaders)
    leaders.map{|i| JSON.parse i.to_json}
  end
end

def get_followers(user_id)
  if $followers_redis.cached? user_id
    followers = $followers_redis.get_json_list(user_id, 0, -1)
  else 
    followers = User.find(user_id).followers
    $followers_redis.push_results(user_id, followers)
    followers.map{|i| JSON.parse i.to_json}
  end
end