ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user" do

  before do
    User.delete_all
    Tweet.delete_all
    Hashtag.delete_all
    TweetsHashtagsRelationship.delete_all

    @u1 = User.new(id: 1, username: 'sjdsf', display_name: 'sjdsf', email: '111@...')
    @u1.password = '123456'
    @u2 = User.new(id: 2, username: 'aaasf', display_name: 'aaasf', email: '112@...')
    @u2.password = '123456'
    @u3 = User.new(id: 3, username: 'sjdff', display_name: 'sjdff', email: '113@...')
    @u3.password = '123456'
    @u1.save
    @u2.save
    @u3.save

    @t1 = Tweet.create(id: 101, user_id: 1, text: 'sdasfsdf', tweet_type: 'ori')
    @t2 = Tweet.create(id: 102, user_id: 2, text: 'dfkii', tweet_type: 'rt', retweet_from_id: 101)
    @t3 = Tweet.create(id: 103, user_id: 2, text: 'sdauujjsdf', tweet_type: 'cm', comment_to_id: 101)
    @t4 = Tweet.create(id: 104, user_id: 3, text: 'dfks', tweet_type: 'rt', retweet_from_id: 101)


    @h1 = Hashtag.create(id: 201, name: 'mdsfkii')
    @h2 = Hashtag.create(id: 202, name: '98sdnsa')
    @h3 = Hashtag.create(id: 203, name: 'sdnfi')
    @h4 = Hashtag.create(id: 204, name: 'f8df8dfkii')

    TweetsHashtagsRelationship.create(hashtag_id: 201, tweet_id: 101)
    TweetsHashtagsRelationship.create(hashtag_id: 201, tweet_id: 102)
    TweetsHashtagsRelationship.create(hashtag_id: 201, tweet_id: 103)

    TweetsHashtagsRelationship.create(hashtag_id: 202, tweet_id: 104)
    TweetsHashtagsRelationship.create(hashtag_id: 203, tweet_id: 104)
    TweetsHashtagsRelationship.create(hashtag_id: 204, tweet_id: 104)
  end

  it 'should have some users and tweets and hashtags' do
    User.all.length.must_equal 3
    Tweet.all.length.must_equal 4
    Hashtag.all.length.must_equal 4
  end

  it 'test h=>t relationships' do
    @h1.tweets.length.must_equal 3
    @h1.tweets.include?(@t1).must_equal true
    @h1.tweets.include?(@t2).must_equal true
    @h1.tweets.include?(@t3).must_equal true

    @t4.hashtags.length.must_equal 3
    @t4.hashtags.include?(@h2).must_equal true
    @t4.hashtags.include?(@h3).must_equal true
    @t4.hashtags.include?(@h4).must_equal true

    @t4.hashtags.include?(@h1).must_equal false

  end

end
