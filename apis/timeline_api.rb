get '/api/timeline' do
  user_id = params['user_id']

  @timeline = Tweet.find_by_sql(["
    SELECT 
      Tweets.*
    FROM Tweets, Follows
    WHERE
      Follows.from_user_id = ? AND
      Tweets.user_id = Follows.to_user_id
    ORDER BY Tweets.updated_at DESC
  ", user_id.to_i])

  if @timeline
    json_response 200, @timeline.to_a
  else
    json_response 404, nil
  end
end