def import_tweets (user_id, num_tweets)
  tweets = []
  columns = [
    :text, :tweet_type, :user_id,
    :comment_to_id, :retweet_from_id,
    :username, :display_name
  ]
  user = User.find(user_id)
  (0..num_tweets-1).each do |i|
    tweets << Tweet.new(
      :text => Faker::String.random.gsub("\u0000", ''),
      :tweet_type => 'orig',
      :user_id => user_id,
      :comment_to_id => 0,
      :retweet_from_id => 0,
      username: user.username,
      display_name: user.display_name
    )
  end
  r = Tweet.import(columns, tweets)
  created_tweets = Tweet.where(id: r.ids)

  created_tweets.each do |ct|
    fanout_helper(user.id, ct)
  end
end
