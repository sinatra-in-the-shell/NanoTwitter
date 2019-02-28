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
  @user = User.new(params[:user])
  @user.password = params[:password]
  @user.save!
  if @user.valid?
    redirect '/', 'register succeeded'
  else
    redirect '/register/', 'register failed'
  end
end

post '/login/?' do
  if (params[:username] =~ URI::MailTo::EMAIL_REGEXP) != nil
    @user = User.find_by_email(params[:username])
  else
    @user = User.find_by_username(params[:username])
  end
  redirect '/login/' unless @user.valid? && @user.correct_password?(params[:password])
  if @user.password == params[:password]
    session[:user] = @user.user
  else
    redirect '/'
  end
end
