# app.rb
require 'sinatra'
require 'sinatra/activerecord'

require 'byebug'
require 'json'

Dir["./models/*.rb"].each {|file| require file }

enable :sessions  

helpers do
end

get '/*' do
  send_file File.expand_path('index.html', settings.public_folder)
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
