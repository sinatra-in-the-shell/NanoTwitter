# app.rb
require 'sinatra'
require 'sinatra/cookies'
require 'sinatra/activerecord'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) if ENV['DATABASE_URL']!=nil

require 'byebug'
require 'json'
require 'bcrypt'
require 'securerandom'
require 'csv'
require 'faker'
require 'activerecord-import'

Dir["./models/*.rb"].each {|file| require file }

enable :sessions

helpers do
  Dir["./helpers/*.rb"].each {|file| require file }
end

before do
  pass if (%w[login register].include?(request.path_info.split('/').last)) || request.path_info.include?('test') || request.path_info.include?('loaderio-2af600f7338436626155976f76115046')
  if not logged_in?
    halt 401, 'not logged_in'
  end
end

# verification for loader.io
get '/loaderio-2af600f7338436626155976f76115046/' do
  send_file File.expand_path('loaderio-2af600f7338436626155976f76115046.txt', settings.public_folder)
end

get '/test/status' do
  erb :status,
      locals: {
        test_id: User.find(email: "testuser@sample.com").id,
        user_count: User.count,
        follow_count: Follow.count,
        tweet_count: Tweet.count
      }
end

get '/*' do
  send_file File.expand_path('index.html', settings.public_folder)
end

# Test Interfaces

# If needed deletes all users, tweets, follows
# Recreates TestUser
# Example: test/reset/all
post '/test/reset/all' do
  reset_all
  create_test_user
end

# Deletes all users, tweets and follows
# Recreate TestUser
# Imports data from standard seed data
post '/test/reset' do
  user_num = params[:users].to_i
  if user_num == nil
    halt 400, "no user count specified."
  else
    reset_all
    seed_file_path = './db/seed/'
    load_seed_users(user_num, seed_file_path+'users.csv')
    load_seed_follows(user_num, seed_file_path+'follows.csv')
    load_seed_tweets(user_num, seed_file_path+'tweets.csv')
    create_test_user(user_num)
  end
end

# POST /test/user/{u}/tweets?count=n
# import_tweet is in helper/random_tweet_helper.rb
post '/test/user/:userid/tweets' do
  print 'userid = ', params['userid'], ' count = ', params['count'], "\n"
  import_tweets(params['userid'].to_i, params['count'].to_i)
# {u} can be the user id of some user, or the keyword testuser
# n is how many randomly generated tweets are submitted on that users behalf
end


# Apis
Dir["./apis/*.rb"].each {|file| require file }
