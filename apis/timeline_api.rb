get '/api/timeline' do
  user = current_user
  limit = params['limit'] || 20

  redis_client = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')

  if redis_client.exists(user.id)
    cached = redis_client.lrange(user.id, 0, -1)
    timeline = []
    cached.each do |c|
      timeline << JSON.parse(c)
    end
    json_response 200, timeline
  else
    # TODO: sometimes duplicate tweets from this query? inside DB there is only one such tweet
    # e.g. id 1684, tweet content is: The SMS sensor is down, program the virtual program so we can connect the USB bus!
    @timeline = Tweet.find_by_sql(["
      SELECT Tweets.*
      FROM Tweets, Follows
      WHERE
        Follows.from_user_id = ? AND
        Tweets.user_id = Follows.to_user_id OR
        Tweets.user_id = ?
      ORDER BY Tweets.updated_at DESC
      LIMIT ?
    ", user.id, user.id, limit])

    begin 
      @timeline.each do |t|
        redis_client.rpush(user.id, t.to_json)
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace.inspect
    end

    if @timeline
      json_response 200, @timeline.to_a
    else
      json_response 404, nil
    end
  end
end
