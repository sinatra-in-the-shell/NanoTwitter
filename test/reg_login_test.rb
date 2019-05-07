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
    post '/api/register', {
      username: 'frank',
      display_name: 'frank',
      email: 'frank@g.com',
      password: '123456'
    }
    assert_equal 200, last_response.status
    @user = User.find_by_username("frank")
    assert @user.valid?
    post '/api/login', {email: 'frank@g.com', password: 'abcdef'}
    assert_equal 401, last_response.status
    post '/api/login', {email: 'frank@g.com', password: '123456'}
    assert_equal 200, last_response.status
  end
end
