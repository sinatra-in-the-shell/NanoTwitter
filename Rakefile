# Rakefile
require './app'
require 'sinatra/activerecord/rake'



require './app'
require 'sinatra/activerecord/rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['test/db_test/test*.rb']
  t.verbose = true
end
