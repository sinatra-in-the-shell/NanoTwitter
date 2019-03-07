def import_tweets (userid, num_tweets)
  tweets = []
  10.times do |i|
    tweets << Tweet.new(:text => Faker::String.random, 
                        :tweet_type => 'orig',
                        :user_id => userid)
  end
  Tweet.import tweets
end