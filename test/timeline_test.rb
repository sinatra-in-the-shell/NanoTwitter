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
    $timeline_redis&.clear
    $leaders_redis&.clear
    $followers_redis&.clear

    User.delete_all
    Follow.delete_all
    Tweet.delete_all

    @user1 = User.new(
      email: 'frank@brandeis.edu',
      username: 'frank',
      display_name: 'frank'
    )
    @user1.password = '123456'
    @user1.save!
    @user2 = User.new(
      email: 'yirunzhou@brandeis.edu',
      username: 'yirun',
      display_name: 'yirun'
    )
    @user2.password = '123456'
    @user2.save!
    @user3 = User.new(
      email: 'ziyuliu@brandeis.edu',
      username: 'ziyu',
      display_name: 'ziyu'
    )
    @user3.password = '123456'
    @user3.save!

    post '/api/follows', {test_user: @user1.id, to_user_id: @user3.id}
    post '/api/follows', {test_user: @user2.id, to_user_id: @user3.id}

    # pp "user3 followers"
    # pp @user3.followers

    Tweet.create user_id: @user3.id,
                 text: 'this is a testing tweet',
                 tweet_type: 'orig'
    Tweet.create user_id: @user3.id,
                 text: 'this is a testing tweet sent in a later time',
                 tweet_type: 'orig'
    Tweet.create user_id: @user3.id,
                 text: 'this is a testing tweet sent in an even later time',
                 tweet_type: 'orig'
  end

  it 'timeline testing' do
    get '/api/timeline', {test_user: @user1.id}
    timeline = JSON.parse(last_response.body)['data']
    assert_equal 'this is a testing tweet', timeline[2]['text']
    assert_equal 'this is a testing tweet sent in a later time', timeline[1]['text']
    assert_equal 'this is a testing tweet sent in an even later time', timeline[0]['text']

    get '/api/timeline', {test_user: @user2.id}
    assert_equal 3, JSON.parse(last_response.body)['data'].length

    get '/api/timeline', {test_user: @user2.id}
    assert_equal 3, JSON.parse(last_response.body)['data'].length
  end

  after do
    $timeline_redis&.clear
    $leaders_redis&.clear
    $followers_redis&.clear
  end
end
