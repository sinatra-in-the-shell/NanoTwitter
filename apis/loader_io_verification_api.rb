get '/loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8/?' do
  send_file File.expand_path('loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8.txt')
end

get '/loaderio-55882d1964da4f66cebe0872aa037d5d/' do
  send_file File.expand_path('loaderio-55882d1964da4f66cebe0872aa037d5d.txt')
end

get '/loaderio/:file' do
  send_file File.expand_path("test/loader_io_test/#{params[:file]}")
end


