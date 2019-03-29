get '/api/timeline' do
  user = current_user
  limit = params['limit'] || 20

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

  if @timeline
    json_response 200, @timeline.to_a
  else
    json_response 404, nil
  end
end

get '/api/timeline/cached' do
  user = current_user

  redis_client = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
  timeline = []
  cached = redis_client.lrange(user.id, 0, -1)

  # any better idea?
  if cached
    cached.each do |c|
      timeline << JSON.parse(c)
    end
    json_response 200, timeline
  else 
    json_response 404, nil
  end
end