ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user and follow" do

  before do
    User.delete_all
    Follow.delete_all

    @u1 = User.new(id: 1, username: 'sjdsf', display_name: 'sjdsf', email: '111@...')
    @u1.password = '123456'
    @u2 = User.new(id: 2, username: 'aaasf', display_name: 'aaasf', email: '112@...')
    @u2.password = '123456'
    @u3 = User.new(id: 3, username: 'sjdff', display_name: 'sjdff', email: '113@...')
    @u3.password = '123456'
    @u1.save
    @u2.save
    @u3.save
    @f1 = Follow.create(from_user_id: 1, to_user_id: 3)
    @f2 = Follow.create(from_user_id: 2, to_user_id: 3)
    @f3 = Follow.create(from_user_id: 1, to_user_id: 2)

  end

  it 'should display some users and follows' do
    User.all.length.must_equal 3
    Follow.all.length.must_equal 3
  end

  it 'should have follow relationships' do
    @u1.following?(@u2).must_equal true
    @u1.following?(@u3).must_equal true

    @u3.followers.include?(@u1).must_equal true
    @u3.followers.include?(@u2).must_equal true
  end
end
