# app.rb
require 'sinatra'
require "sinatra/activerecord"

require 'byebug'


require './models/user.rb'
require './models/follow.rb'
require './models/tweet.rb'
require './models/like.rb'
require './models/hashtag.rb'
require './models/tweets_hashtags_relationship.rb'

get '/' do
  "Hello Sinatra!"
end
