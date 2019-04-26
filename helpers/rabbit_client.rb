class RabbitClient
  attr_accessor :calls, :connection, :channel, :helper,
                :server_queue_name, :reply_queue, :exchange

  def initialize(rabbit_url, server_queue_name)
    if rabbit_url
      @connection = Bunny.new rabbit_url
    else
      @connection = Bunny.new(tls: false)
    end
    @connection.start

    @channel = connection.create_channel
    @exchange = channel.default_exchange
    @server_queue_name = server_queue_name

    setup_reply_queue
  end

  def call(params, timeout=5)
    call_id = generate_uuid

    exchange.publish(
      params.to_json,
      routing_key: server_queue_name,
      correlation_id: call_id,
      reply_to: reply_queue.name
    )
    loop do
      sleep 0.1
      timeout -= 0.1
      break if calls[call_id]
      break if timeout <= 0
    end

    if calls[call_id].nil?
      return JSON.parse rabbit_response(504, nil, 'time out')
    end

    JSON.parse calls.delete(call_id)
  end

  def stop
    channel.close
    connection.close
  end

  private

  def setup_reply_queue
    @reply_queue = channel.queue('', exclusive: true)
    @calls = {}

    reply_queue.subscribe do |delivery_info, properties, payload|
      response_id = properties[:correlation_id]
      calls[response_id] = payload
    end
  end

  def generate_uuid
    # very naive but good enough for code examples
    "#{Time.now.to_i}#{rand}#{rand}"
  end
end
