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
    $followers_redis&.clear

    User.delete_all
    Follow.delete_all

    post '/api/register', {
      email: 'frank@brandeis.edu',
      username: 'frank',
      display_name: 'frank',
      password: '123456'
    }
    @user1 = User.find_by(username: 'frank')

    post '/api/register', {
      email: 'yirunzhou@brandeis.edu',
      username: 'yirun',
      display_name: 'yirun',
      password: '123456'
    }
    @user2 = User.find_by(username: 'yirun')

    post '/api/register', {
      email: 'ziyuliu@brandeis.edu',
      username: 'ziyu',
      display_name: 'ziyu',
      password: '123456'
    }
    @user3 = User.find_by(username: 'ziyu')

    delete '/api/logout'

    post '/api/follows', {test_user: @user1.id, to_user_id: @user3.id}
    assert_equal @user3.id, JSON.parse(last_response.body)['data']['to_user_id']

    post '/api/follows', {test_user: @user2.id, to_user_id: @user3.id}
    assert_equal @user2.id, JSON.parse(last_response.body)['data']['from_user_id']
  end

  it 'new follow' do
    assert_equal 2, Follow.all.length
  end

  it 'followers' do
    get '/api/follows/followers', {test_user: @user3.id}
    assert_equal 2, JSON.parse(last_response.body)['data'].length

    get '/api/follows/followers', {test_user: @user3.id}
    assert_equal 2, JSON.parse(last_response.body)['data'].length
  end

  after do
    $followers_redis&.clear
  end
end
