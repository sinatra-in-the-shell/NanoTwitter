class RabbitServer

  def initialize(rabbit_url=nil)
    if rabbit_url
      @connection = Bunny.new rabbit_url
    else
      @connection = Bunny.new tls: false
    end
    @connection.start
    @channel = @connection.create_channel
  end

  def start(queue_name, helper)
    @helper = helper
    @queue = channel.queue(queue_name)
    @exchange = channel.default_exchange
    subscribe_to_queue
  end

  def stop
    channel.close
    connection.close
  end

  private

  attr_reader :channel, :exchange, :queue, :connection, :helper

  def subscribe_to_queue
    queue.subscribe do |delivery_info, properties, payload|
      req = JSON.parse payload
      result = helper.process req

      exchange.publish(
        result,
        routing_key: properties.reply_to,
        correlation_id: properties.correlation_id
      )
    end
  end
end
