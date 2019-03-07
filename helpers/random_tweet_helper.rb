def import_tweets (userid, num_tweets)
  tweets = []
  num_tweets.times do |i|
    # text = Faker::String.random
    tweets << Tweet.create(:text => 'text test', 
                        :tweet_type => 'orig',
                        :user_id => userid,
                        :comment_to_id => 0,
                        :retweet_from_id => 0)
  end
  Tweet.import tweets
end

