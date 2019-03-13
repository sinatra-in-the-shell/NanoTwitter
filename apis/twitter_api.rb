post '/api/tweets' do
  @user = current_user
  @tweet = Tweet.new(
    user: @user,
    comment_to_id: params['comment_to_id'],
    retweet_from_id: params['retweet_from_id'],
    text: params['text'],
    params['tweet_type']
  )
  if @tweet.save
    status 201
  else
    status 400
    @tweet.errors.messages.to_json
  end
end

get '/api/tweets' do
  from = params['skip'].to_i
  count = params['maxResults'].to_i
  @tweets = Tweet.offset(from).limit(count).to_json
end

get '/api/tweets/:id' do
  @tweet = Tweet.find(params[:id])
  if @tweet
    status 200
    @tweet.to_json
  else
    status 404
  end
end
