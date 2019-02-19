ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user" do

  before do
    User.delete_all
    @u1 = User.create(id: 1, username: 'sjdsf', email: '111@...')
    @u2 = User.create(id: 2, username: 'aaasf', email: '112@...')
    @u3 = User.create(id: 3, username: 'sjdff', email: '113@...')
  end

  it 'should have some users' do
    User.all.length.must_equal 3
  end

end
