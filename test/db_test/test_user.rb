ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user" do

  before do
    User.delete_all
    @u1 = User.new(id: 1, username: 'sjdsf', display_name: 'sjdsf', email: '111@...')
    @u1.password = '123456'
    @u2 = User.new(id: 2, username: 'aaasf', display_name: 'aaasf', email: '112@...')
    @u2.password = '123456'
    @u3 = User.new(id: 3, username: 'sjdff', display_name: 'sjdff', email: '113@...')
    @u3.password = '123456'
    @u1.save
    @u2.save
    @u3.save
  end

  it 'should have some users' do
    User.all.length.must_equal 3
  end

end
