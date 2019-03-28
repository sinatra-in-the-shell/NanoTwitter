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
    Follow.delete_all
    # register api will fail
    post '/api/users', {username: 'frank', password: '123456'}
    @user1 = User.find_by_username('frank')

    # more user creations will fail
    # post '/api/users', {username: 'yirun', password: 'dfssdfdsf'}
    # @user2 = User.find_by_username('yirun')

    # post '/api/users', {username: 'ziyu', password: 'sdfsfsfsdf'}
    # @user3 = User.find_by_username('ziyu')
  end

  it 'new follow' do
    post '/api/follows', {user_id: @user1.id, to_user_id: 3}
    assert_equal 3, JSON.parse(last_response.body)['data']['to_user_id']
    assert_equal 1, Follow.all.length    
  end

  it 'followers' do
    
  end

end
