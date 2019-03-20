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
require 'newrelic_rpm'

Dir["./models/*.rb"].each {|file| require file }

enable :sessions

helpers do
  Dir["./helpers/*.rb"].each {|file| require file }
end

before do
  pass if (%w[login register].include?(request.path_info.split('/').last)) \
           || request.path_info.include?('test') \
           || request.path_info.include?('loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8')\
           || request.path_info.include?('testing-token=sits-testing')
  if not logged_in?
    halt 401, 'not logged_in'
  end
end

# Apis
Dir["./apis/*.rb"].each {|file| require file }

get '/*' do
  send_file File.expand_path('index.html', settings.public_folder)
end
