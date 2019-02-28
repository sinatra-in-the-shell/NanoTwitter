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
require './models/notification.rb'

enable :sessions  

helpers do
end

get '/' do
  "Hello Sinatra!"
end

post '/register/?' do
  @user = User.new(username: params[:username])
  @user.password = (params[:password])
  @user.save!
  if @user.valid?
    'register succeeded'
  else
    'register failed'
  end
end

post '/login/?' do

  if (params[:username] =~ URI::MailTo::EMAIL_REGEXP) != nil
    @user = User.find_by_email(params)
  else
    @user = User.find_by_username(params[:username])
  end
  if @user.valid? && @user.password == params[:password]
    session[:user] = @user.username
    'Login Succeeded'
  else
    halt 401, 'Incorrect username or password.'
  end
end
