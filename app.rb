# app.rb
require 'sinatra'
require 'sinatra/activerecord'

require 'byebug'
require 'json'

Dir["./models/*.rb"].each {|file| require file }

get '/' do
  "Hello Sinatra!"
end

post '/api/login' do
  puts params[:email]
  puts params[:password]
  JSON.generate({ authenticated: true, msg: "successful" })
end
