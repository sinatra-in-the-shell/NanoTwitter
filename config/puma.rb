workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['THREAD_COUNT'] || 10)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

worker_timeout 5

on_worker_boot do
    ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.establish_connection
    end
end