require 'sidekiq'

class NewTweetWorker
  include Sidekiq::Worker

  def perform(tweet)
    #TODO: error handling
    tweet.save
    fanout_helper(@user.id, @tweet)
  end
end