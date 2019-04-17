#!/usr/bin/env ruby
require 'sinatra/activerecord'
require 'json'
require 'bunny'
require 'securerandom'
require 'redis'
require './helpers/redis_client_helper.rb'

Dir["./models/*.rb"].each {|file| require file }

class TimelineServer
  def initialize
    @connection = Bunny.new(ENV["RABBITMQ_URL"])
    @connection.start
    @channel = @connection.create_channel
  end

  def start(queue_name)
    @queue = channel.queue(queue_name)
    @exchange = channel.default_exchange
    subscribe_to_queue
  end

  def stop
    channel.close
    connection.close
  end

  private

  attr_reader :channel, :exchange, :queue, :connection

  def subscribe_to_queue
    queue.subscribe(block: true) do |_delivery_info, properties, payload|
      req_message = JSON.parse payload

      result = get_timeline(req_message['params'][0], req_message['params'][1])

      reply = {
        'id' => req_message['id'],
        'result' => result,
        'jsonrpc' => '2.0'
      }

      exchange.publish(
        reply.to_json,
        routing_key: properties.reply_to,
        correlation_id: properties.correlation_id
      )
    end
  end

  def get_timeline(user_id, limit)
    timeline_redis = RedisClient.new(ENV['REDIS_URL'])
    user = User.find(user_id)
    @timeline = nil

    if timeline_redis.cached?(user.id)
      begin
        @timeline = timeline_redis.get_list(user.id, 0, -1)
      rescue StandardError => e
        pp e.message
      end
    else 
      # TODO: using redis to get whose tweets to collect
      # get_timeline_uncached(user.id, limit)

      @timeline = Tweet.find_by_sql(["
        SELECT DISTINCT tweets.*
        FROM tweets, follows
        WHERE
          follows.from_user_id = ? AND
          (tweets.user_id = follows.to_user_id OR
          tweets.user_id = ?)
        ORDER BY tweets.updated_at DESC
        LIMIT ?
      ", user.id, user.id, limit])
      begin
        timeline_redis.push_results(user.id, @timeline)
      rescue StandardError => e
        pp e.message
      end
    end
    @timeline
  end

  def get_timeline_uncached(user_id, limit)
    leader_ids = get_leader_ids(user_id)
    leaders_tweets = []
    leader_ids.each do |leader_id|
      leaders_tweets.concat Tweet.where('user.id' => leader_id).desc(:created_at).limit(limit)
    end
    leaders_tweets.sort_by { |t| t[:created_at] }.reverse!
    leaders_tweets.slice(0, 50)
  end

  # TODO: create leaders_redis
  def get_leader_ids(user_id)
    $leaders_redis = RedisClient.new(ENV['leaders_redis'])
    $leaders_redis.get_list(user_id, 0, -1)
  end
end

begin
  server = TimelineServer.new
  queue_name = 'timeline_request_queue'
  puts " [x] Awaiting timeline requests at queue name : '#{queue_name}'"
  server.start(queue_name)
rescue Interrupt => _
  server.stop
end