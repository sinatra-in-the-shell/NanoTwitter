# require 'bunny'
# require 'thread'
# require 'securerandom'
# require 'json'

# class TimelineClient
#   attr_accessor :call_id, :response, :lock, :condition, :connection,
#                 :channel, :server_queue_name, :reply_queue, :exchange

#   def initialize(server_queue_name)
#     @connection = Bunny.new(ENV["RABBITMQ_URL"], automatically_recover: false)
#     @connection.start

#     @channel = connection.create_channel
#     @exchange = channel.default_exchange
#     @server_queue_name = server_queue_name

#     setup_reply_queue
#   end

#   def call(user_id, limit)
#     req_message = {
#       'id' => SecureRandom.hex,
#       'jsonrpc' => '2.0',
#       'params' => [user_id, limit]
#     }
#     exchange.publish(JSON.generate(req_message),
#                      routing_key: server_queue_name,
#                      correlation_id: req_message[:id],
#                      reply_to: reply_queue.name)
#     lock.synchronize { condition.wait(lock) }

#     response
#   end

#   def stop
#     channel.close
#     connection.close
#   end

#   private

#   def setup_reply_queue
#     @lock = Mutex.new
#     @condition = ConditionVariable.new
#     that = self
#     @reply_queue = channel.queue('', exclusive: true)

#     reply_queue.subscribe do |_delivery_info, properties, payload|
#       if properties[:correlation_id] == that.call_id
#         that.response = JSON.parse(payload)['result']
#         that.lock.synchronize { that.condition.signal }
#       end
#     end
#   end

# end

# # client = TimelineClient.new('timeline_request_queue')

# # puts ' [x] Requesting timeline(13, 20)'
# # response = client.call(13, 20)

# # puts " [.] Got #{response}"

# # client.stop