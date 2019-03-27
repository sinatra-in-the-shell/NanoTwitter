post '/api/tweets' do
  # if we do not have current user (testing cases)
  @user = current_user || User.find(params['user_id'])
  @tweet = Tweet.new(
    user: @user,
    comment_to_id: params['comment_to_id'],
    retweet_from_id: params['retweet_from_id'],
    text: params['text'],
    tweet_type: params['tweet_type']
  )

  if @tweet.save
    # fanout after save 
    fanout_helper(@user, @tweet)
    json_response 201, nil
  else
    json_response 400, nil, @tweet.errors.full_messages
  end
end

get '/api/tweets' do
  skip = params['skip']
  max_results = params['maxresults']
  @tweets = Tweet.with_skip(skip).with_max(max_results)
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end

get '/api/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  if @tweet
    json_response 200, @tweet
  else
    json_response 404, nil
  end
end
