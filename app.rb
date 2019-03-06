# app.rb
require 'sinatra'
require 'sinatra/cookies'
require 'sinatra/activerecord'
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) if ENV['DATABASE_URL']!=nil

require 'byebug'
require 'json'
require 'bcrypt'
require 'securerandom'

Dir["./models/*.rb"].each {|file| require file }

enable :sessions

helpers do
  Dir["./helpers/*.rb"].each {|file| require file }
end

before do
  pass if %w[login register].include? request.path_info.split('/').last
  if not logged_in?
    halt 401, 'not logged_in'
  end
end

get '/*' do
  send_file File.expand_path('index.html', settings.public_folder)
end

# Test Interfaces

# If needed deletes all users, tweets, follows
# Recreates TestUser
# Example: test/reset/all
post '/test/reset/all' do

end

# Deletes all users, tweets and follows
# Recreate TestUser

post '/test/reset' do
  user_num = params[:users]
  if user_num == nil
    halt 400, "no user count specified."
  else
    
  end

end

# Apis
Dir["./apis/*.rb"].each {|file| require file }
