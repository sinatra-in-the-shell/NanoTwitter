get '/api/search/tags' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  from_date = params['fromDate']
  to_date = params['toDate']
  @tags = Tag.where(
               "created_at > ? AND created_at < ?",
               DateTime.new(from_date),
               DateTime.new(to_date)
             )
             .where("name LIKE ?", "%#{keyword}%")
             .offset(skip).limit(max_results)
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end

get '/api/search/tweets' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  from_date = params['fromDate']
  to_date = params['toDate']
  @tweets = Tweet.where(
                   "created_at > ? AND created_at < ?",
                   DateTime.new(from_date),
                   DateTime.new(to_date)
                 )
                 .where("text LIKE ?", "%#{keyword}%")
                 .offset(skip).limit(max_results)
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end

get '/api/search/users' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  @users = User.where("username LIKE ?", "%#{keyword}%")
               .offset(skip).limit(max_results)
  if @users
    json_response 200, @users.to_a
  else
    json_response 404, nil
  end
end
