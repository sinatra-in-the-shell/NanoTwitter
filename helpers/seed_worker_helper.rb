Sidekiq.configure_server do |config|
  config.redis = { url: ENV['SIDEKIQ_URL'] }
end

class SomeWorker
  include Sidekiq::Worker
  def perform(complexity)
    pp ENV['SIDEKIQ_URL']
    ## TODO: seed db
  end
end
