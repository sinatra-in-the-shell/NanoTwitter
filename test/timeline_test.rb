ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "test timeline" do
  before do
    User.delete_all
    Follow.delete_all
    Tweet.delete_all

    post '/api/users', { email: 'frank@brandeis.edu', username: 'frank', password: '123456'}
    @user1 = User.find_by(username: 'frank')
    post '/api/users', {email: 'yirunzhou@brandeis.edu', username: 'yirun', password: '123456'}
    @user2 = User.find_by(username: 'yirun')
    post '/api/users', {email: 'ziyuliu@brandeis.edu', username: 'ziyu', password: '123456'}
    @user3 = User.find_by(username: 'ziyu')

    delete '/api/logout'

    post '/api/follows', {test_user: @user1.id, to_user_id: @user3.id}
    post '/api/follows', {test_user: @user2.id, to_user_id: @user3.id}
  
    post '/api/tweets', {test_user: @user3.id, 
                        comment_to_id: 0,
                        retweet_from_id: 0,
                        text: 'this is a testing tweet',
                        tweet_type: 'orig'}

    post '/api/tweets', {test_user: @user3.id, 
                        comment_to_id: 0,
                        retweet_from_id: 0,
                        text: 'this is a testing tweet sent in a later time',
                        tweet_type: 'orig'}

    post '/api/tweets', {test_user: @user3.id, 
                        comment_to_id: 0,
                        retweet_from_id: 0,
                        text: 'this is a testing tweet sent in an even later time',
                        tweet_type: 'orig'}
  end

  it 'timeline testing' do
    get '/api/timeline', {test_user: @user1.id}
    timeline = JSON.parse(last_response.body)['data']
    assert_equal 'this is a testing tweet', timeline[2]['text']
    assert_equal 'this is a testing tweet sent in a later time', timeline[1]['text']
    assert_equal 'this is a testing tweet sent in an even later time', timeline[0]['text']

    get '/api/timeline', {test_user: @user2.id}
    assert_equal 3, JSON.parse(last_response.body)['data'].length
  end
end
