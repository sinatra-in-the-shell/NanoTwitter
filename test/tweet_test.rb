ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'
include Rack::Test::Methods
def app
  Sinatra::Application
end

describe "test new tweets" do
  before do
    User.delete_all
    Tweet.delete_all
  end

  it 'new tweet' do
    post '/api/register', {username: 'frank', password: '123456'}
    @user = User.find_by_username('frank')

    #directly access db will fail, why???
    # @user = User.create(username: 'gz', password: 'sdfsdfsf')

    tweet_text = Faker::String.random.gsub("\u0000", '')
    post '/api/tweets', { user: @user,
                          comment_to_id: 0,
                          retweet_from_id: 0,
                          text: tweet_text,
                          tweet_type: 'orig'}

    assert_equal JSON.parse(last_response.body)['data']['text'], tweet_text
    @tweet = Tweet.find_by_text(tweet_text)
    assert @tweet.valid?
    assert_equal @tweet.user_id, @user.id

    Tweet.delete_all
  end

  it 'get all tweets' do
    post '/api/register', {username: 'frank', password: '123456'}
    @user = User.find_by_username('frank')

    (0..3).each do |i|
      post '/api/tweets', { user: @user,
                            comment_to_id: 0,
                            retweet_from_id: 0,
                            text: Faker::String.random.gsub("\u0000", ''),
                            tweet_type: 'orig'}
    end

    assert_equal Tweet.all.length, 4
  end
end
