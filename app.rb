# app.rb
require 'sinatra'
require 'sinatra/cookies'
require 'sinatra/activerecord'
require 'textacular'
ActiveRecord::Base.extend(Textacular)
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) if ENV['DATABASE_URL']!=nil

require 'byebug'
require 'json'
require 'bcrypt'
require 'securerandom'
require 'csv'
require 'faker'
require 'activerecord-import'
require 'newrelic_rpm'
require 'redis'
require 'sidekiq'
require 'securerandom'
require 'dotenv/load'
require 'bunny'
require 'securerandom'
require 'puma'

Dir["./models/*.rb"].each {|file| require file }

# set :server, "thin"
configure { set :server, :puma }

enable :sessions

helpers do
  Dir["./helpers/*.rb"].each {|file| require file }
end

# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV['SIDEKIQ_URL'] }
# end


# init redis client, maybe put into another file for cleaness
$followers_redis = RedisClient.new(ENV['FOLLOWERS_REDIS'])
$leaders_redis = RedisClient.new(ENV['LEADERS_REDIS'])
$timeline_redis = RedisClient.new(ENV['TIMELINE_REDIS'])
$search_redis = RedisClient.new(ENV['SEARCH_REDIS'])
puts "REDIS INITIALIZED:"
print "Search Redis:"
pp $search_redis
$followers_redis.clear
$leaders_redis.clear
$timeline_redis.clear
$search_redis.clear

$rabbit_client = RabbitClient.new(ENV['RABBITMQ_URL'], 'tweet_server')

before do
  pass if (%w[login register].include?(request.path_info.split('/').last)) \
           || request.path_info.include?('test')\
           || request.path_info.include?('loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8') \
           || params[:test_user]
  if not logged_in?
    # if request.path_info.include?('api')
    #   halt 401, {errors: 'not logged in'}.to_json
    # els
    if request.get?
      redirect '/login', 303
    else
      halt 401, 'not logged in'
    end
  end
end

# Apis
Dir["./apis/*.rb"].each {|file| require file }

get '/*' do
  puts "logged in"
  send_file File.expand_path('index.html', settings.public_folder)
end
