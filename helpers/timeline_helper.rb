def get_timeline(user_id, limit)
  leaders_ids = get_leaders_ids(user_id)
  return [] if leaders_ids.nil?
  leaders_tweets = Tweet.where(user_id: leaders_ids).limit(limit)
  sorted = leaders_tweets.sort_by { |t| t[:created_at] }.reverse!
end