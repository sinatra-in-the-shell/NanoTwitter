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
  pass if %w[login register].include? request.path_info.split('/')[2]
  if not logged_in?
    halt 401, 'not logged_in'
  end
end

get '/*' do
  send_file File.expand_path('index.html', settings.public_folder)
end

Dir["./apis/*.rb"].each {|file| require file }
