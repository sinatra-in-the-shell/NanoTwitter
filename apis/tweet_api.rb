post '/api/tweets' do
  @user = current_user
  @tweet = Tweet.new(
    user: @user,
    comment_to_id: params['comment_to_id'],
    retweet_from_id: params['retweet_from_id'],
    text: params['text'],
    tweet_type: params['tweet_type']
  )
  if @tweet.save
    json_response 201, nil
  else
    json_response 400, nil, @tweet.errors.messages
  end
end

get '/api/tweets' do
  skip = params.key?(:skip) ? params['skip'].to_i : 0
  max_results = params.key(:maxresults) ? params['maxresults'].to_i : 1000
  @tweets = Tweet.offset(skip).limit(max_results)
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
