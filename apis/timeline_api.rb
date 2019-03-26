get '/api/timeline' do
  user = current_user

  @timeline = Tweet.find_by_sql(["
    SELECT Tweets.*
    FROM Tweets, Follows
    WHERE
      Follows.from_user_id = ? AND
      Tweets.user_id = Follows.to_user_id OR
      Tweets.user_id = ?
    ORDER BY Tweets.updated_at DESC
    LIMIT 20
  ", user.id, user.id])

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

  if cached
    cached.each do |c|
      timeline << JSON.parse(c)
    end
    json_response 200, timeline
  else 
    json_response 404, nil
  end
end