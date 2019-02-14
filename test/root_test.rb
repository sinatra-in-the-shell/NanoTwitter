# test/root_test.rb
ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'The HelloWorld App' do
  it "says hello" do
    get '/'
    last_response.ok?
    last_response.body.must_equal 'Hello Sinatra!'
  end
end
