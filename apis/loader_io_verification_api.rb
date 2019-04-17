get '/loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8/?' do
  send_file File.expand_path('loaderio-b2296ad8f5d2ab4dfcc4ce34a0d36fa8.txt')
end

get '/loaderio/test1.json' do
  send_file File.expand_path('test/loader_io_test/test1.json')
end
