def follow_server
  unless $follow_server
    $follow_server = RabbitServer.new ENV['CLOUDAMQP_COBALT_URL']
    $follow_server.start 'follow_queue', FollowHelper.new
    pp "follow server started"
  end
  $follow_server
end

def tweet_client
  unless $tweet_client
    $tweet_client = RabbitClient.new(
      ENV['RABBITMQ_URL'],
      'tweet_queue'
    )
    pp "tweet client started"
  end
  $tweet_client
end
