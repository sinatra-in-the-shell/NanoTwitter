get '/api/timeline/?' do
  user = current_user
  limit = params['limit'] || 20
  redis_client = RedisClient.new(ENV['REDIS_URL'] || 'redis://localhost:6379')

  if redis_client.cached?(user.id)
    begin
      timeline = redis_client.get_json_list(user.id, 0, -1)
      json_response 200, timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  else 
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
      redis_client.push_results(user.id, @timeline)
      json_response 200, @timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  end
end
