# app.rb
require 'sinatra'
require "sinatra/activerecord"

require 'byebug'


require './models/user.rb'
require './models/follow.rb'
require './models/tweet.rb'



get '/' do
  "Hello Sinatra!"
end
