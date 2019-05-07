ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user" do

  before do
    User.delete_all
    Tweet.delete_all
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
  end

  it 'should have some users and tweets' do
    User.all.length.must_equal 3
    Tweet.all.length.must_equal 4
  end

  it 'has many and belongs to relations' do
    @u1.tweets.include?(@t1).must_equal true
    @u1.tweets.include?(@t3).must_equal false
    @u2.tweets.include?(@t2).must_equal true
    @u2.tweets.include?(@t3).must_equal true
  end


  it 'test retweet' do
    @t1.retweets.include?(@t2).must_equal true
    @t1.retweets.include?(@t4).must_equal true
    @t1.retweets.include?(@t3).must_equal false
  end

  it 'test comment' do
    @t1.comments.include?(@t3).must_equal true
    @t1.comments.include?(@t4).must_equal false
  end

end
