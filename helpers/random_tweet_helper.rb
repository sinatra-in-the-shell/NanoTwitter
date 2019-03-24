def import_tweets (userid, num_tweets)
  tweets = []
  columns = [:text, :tweet_type, :user_id, :comment_to_id, :retweet_from_id]
  (0..num_tweets).each do |i|
    tweets << Tweet.new(
                        :text => Faker::String.random.gsub("\u0000", ''), 
                        :tweet_type => 'orig',
                        :user_id => userid,
                        :comment_to_id => 0,
                        :retweet_from_id => 0)
  end
  Tweet.import(columns, tweets)

  pp Tweet.all
end


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

