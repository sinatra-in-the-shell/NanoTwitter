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

    post '/api/users', {email: 'frank@brandeis.edu', username: 'frank', password: '123456'}
    @user1 = User.find_by_username('frank')

    post '/api/users', {email: 'yirunzhou@brandeis.edu', username: 'yirun', password: 'dfssdfdsf'}
    @user2 = User.find_by(username: 'yirun')

    post '/api/users', {email: 'ziyuliu@brandeis.edu', username: 'ziyu', password: 'sdfsfsfsdf'}
    @user3 = User.find_by_username('ziyu')
    pp @user3
    delete '/api/logout/'
  end

  it 'new follow' do
    post '/api/follows', {user_id: @user1.id, to_user_id: @user3.id}
    assert_equal @user3.id, JSON.parse(last_response.body)['data']['to_user_id']

    post '/api/follows', {user_id: @user2.id, to_user_id: @user3.id}
    assert_equal @user2.id, JSON.parse(last_response.body)['data']['from_user_id']

    assert_equal 2, Follow.all.length

    delete '/api/logout/'
    get '/api/followers', params: {user_id: @user3.id}
    # pp last_response.body
  end

  
end
