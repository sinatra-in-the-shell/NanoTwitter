ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test likes" do

  before do
    User.delete_all
    Tweet.delete_all
    Like.delete_all

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


    @l1 = Like.create(user_id: 1, tweet_id: 101)
    @l2 = Like.create(user_id: 2, tweet_id: 101)
    @l3 = Like.create(user_id: 3, tweet_id: 102)
    @l4 = Like.create(user_id: 3, tweet_id: 103)

  end

  it 'should have some users and tweets' do
    User.all.length.must_equal 3
    Tweet.all.length.must_equal 4
    Like.all.length.must_equal 4
  end

  it 'user has many likes' do
    @u3.likes.include?(@l3).must_equal true
    @u3.likes.include?(@l4).must_equal true
    @u3.likes.include?(@l1).must_equal false
    @u1.likes.include?(@l1).must_equal true
  end


end
