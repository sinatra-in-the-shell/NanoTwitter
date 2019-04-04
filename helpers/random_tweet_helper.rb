def import_tweets (user_id, num_tweets)
  tweets = []
  columns = [:text, :tweet_type, :user_id, :comment_to_id, :retweet_from_id]
  (0..num_tweets-1).each do |i|
    tweets << Tweet.new(
                        :text => Faker::String.random.gsub("\u0000", ''), 
                        :tweet_type => 'orig',
                        :user_id => user_id,
                        :comment_to_id => 0,
                        :retweet_from_id => 0)
  end
  r = Tweet.import(columns, tweets)
  created_tweets =  Tweet.where(id: r.ids)
  user = User.find(user_id)
  created_tweets.each do |ct|
    fanout_helper(user, ct)
  end
end

# change from user to user_id
# def import_tweets_fanout(user_id, num_tweets)
#   user = User.find(user_id)
#   (0..num_tweets-1).each do |i|
#     tweet = Tweet.new(
#                       :text => Faker::String.random.gsub("\u0000", ''), 
#                       :tweet_type => 'orig',
#                       :user_id => user_id,
#                       :comment_to_id => 0,
#                       :retweet_from_id => 0)
#     if tweet.save
#       fanout_helper(user, tweet)
#     end
#   end
# end

# create_table "tweets", force: :cascade do |t|
#   t.bigint "user_id"
#   t.bigint "comment_to_id"
#   t.bigint "retweet_from_id"
#   t.text "text"
#   t.string "tweet_type"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["comment_to_id"], name: "index_tweets_on_comment_to_id"
#   t.index ["retweet_from_id"], name: "index_tweets_on_retweet_from_id"
#   t.index ["user_id"], name: "index_tweets_on_user_id"
# end

