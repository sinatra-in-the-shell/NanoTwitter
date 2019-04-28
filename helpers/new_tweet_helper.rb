def create_new_tweet(user, params)
  Tweet.new(
    user_id: user.id,
    comment_to_id: params['comment_to_id'],
    retweet_from_id: params['retweet_from_id'],
    text: params['text'],
    tweet_type: 'orig' || params['tweet_type'],
    username: user.username,
    display_name: user.display_name
  )
end

def scan_and_create_hashtags(tweet)
  tweet.text.scan(/#\w+/).flatten.each do |_tag|
    _tag.slice!(0)
    tag = Hashtag.find_by_name(_tag)
    tag = Hashtag.create(name: _tag) if tag.nil?
    tweet.hashtags << tag
  end
end

def post_random_tweet (user)
  tweet_pool = CSV.read('db/seed/sample_tweets.csv')
  # ["992", "#Apple reportedly raises up to $1.2B in first Taiwanese bond."]
  tweet_content = tweet_pool.sample[1]
  @tweet = Tweet.new(
    user_id: user.id,
    comment_to_id: nil,
    retweet_from_id: nil,
    text: tweet_content,
    tweet_type: 'orig',
    username: user.username,
    display_name: user.display_name
  )
end
