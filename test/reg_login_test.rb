ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'
include Rack::Test::Methods
def app
  Sinatra::Application
end

describe "test user register and login" do
  before do
    User.delete_all
  end

  it 'should be able to register and login' do
    post '/api/register', {username: 'frank', password: '123456'}
    assert_equal last_response.status, 204
    @user = User.find_by_username("frank")
    assert @user.valid?
    post '/api/login', {username: 'frank', password: 'abcdef'}
    assert_equal last_response.status, 401
    post '/api/login', {username: 'frank', password: '123456'}
    assert_equal last_response.status, 204
  end
end