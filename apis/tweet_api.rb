post '/api/tweets/?' do
  # TODO: Save tweet into database only when Redis missed.
  #       Otherwise only save in Redis.
  @user = current_user

  @tweet = create_new_tweet(@user, params)
  if params['service'] == 'yes'
    res = tweet_client.call(
      method: 'new_tweet',
      args: @tweet.as_json
    )
    return json_response res['status'], res['data'], res['errors']
  end

  #find hashtags in the tweet
  scan_and_create_hashtags(@tweet)

  if @tweet.save
    fanout_helper(@user.id, @tweet)
    json_response 200, @tweet
  else
    json_response 400, nil, @tweet.errors.full_messages
  end
end

get '/api/tweets/:id/comments/?' do
  @tweets = Tweet.find(params[:id]).comments
  if @tweets
    json_response 200, @tweets
  else
    json_response 404, nil
  end
end

get '/api/tweets/:id/?' do
  @tweet = Tweet.find(params[:id])
  if @tweet
    json_response 200, @tweet
  else
    json_response 404, nil
  end
end

get '/api/tweets/?' do
  skip = params['skip']
  max_results = params['maxresults']
  @tweets = Tweet.with_skip(skip).with_max(max_results)
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end

post '/api/likes/?' do
  @like = Like.find_by(
    user_id: current_user.id,
    tweet_id: params['tweet_id']
  )
  if @like
    res = @like.destroy
  else
    @like = Like.new(
      user_id: current_user.id,
      tweet_id: params['tweet_id']
    )
    res = @like.save
  end
  if res
    json_response 200
  else
    json_response 400
  end
end
