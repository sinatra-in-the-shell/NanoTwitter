ENV['APP_ENV'] = 'test'

require './app.rb'
require 'minitest/autorun'
require 'rack/test'

describe "test user and follow" do

  before do
    User.delete_all
    Follow.delete_all

    @u1 = User.create(id: 1, username: 'sjdsf', email: '111@...')
    @u2 = User.create(id: 2, username: 's2odsf', email: '112@...')
    @u3 = User.create(id: 3, username: 'sjf', email: '113@...')
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
