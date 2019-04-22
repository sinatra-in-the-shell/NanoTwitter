post '/api/tweets/?' do
  @user = current_user
  @tweet = Tweet.new(
    user: @user,
    comment_to_id: params['comment_to_id'],
    retweet_from_id: params['retweet_from_id'],
    text: params['text'],
    tweet_type: params['tweet_type'],
    username: @user.username,
    display_name: @user.display_name
  )
  #find hashtags in the tweet
  params['text'].scan(/#\w+/).flatten.each do |tag|
    @tag = Hashtag.find_by_name(tag)
    @tag = Hashtag.create(name: tag) if @tag == nil
    @tweet.hashtags << @tag
  end
  if @tweet.save
    fanout_helper(@user.id, @tweet)
    json_response 200, @tweet
  else
    json_response 400, nil, @tweet.errors.full_messages
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

get '/api/tweets/:id/?' do
  @tweet = Tweet.find(params[:id])
  if @tweet
    json_response 200, @tweet
  else
    json_response 404, nil
  end
end

post '/api/tweets/rpc/?' do
  params['method'] = 'new_tweet'
  params.delete 'test_user'
  res = $rabbit_client.call params
  pp res
  json_response 200, JSON.parse(res)
end