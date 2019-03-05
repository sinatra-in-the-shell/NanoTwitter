# Rakefile
# require './app'
# require 'sinatra/activerecord'
# require 'sinatra/activerecord/rake'
#
#
# require 'rake/testtask'
#
# Rake::TestTask.new do |t|
#   t.libs << "tests"
#   t.test_files = FileList['test/db_test/test*.rb']
#   t.verbose = true
# end
# damn codeship!

require './app'
require 'sinatra/activerecord/rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "tests"
  t.test_files = FileList['test/db_test/test*.rb', 'test/*.rb']
  t.verbose = true
end
