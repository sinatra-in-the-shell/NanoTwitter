get '/api/search/tags' do
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  from_date = params['fromDate']
  to_date = params['toDate']
  @tags = Tag.with_keyword(keyword)
             .after_date(from_date)
             .before_date(to_date)
             .with_skip(skip)
             .with_max(max_results)
  if @tags
    json_response 200, @tags.to_a
  else
    json_response 404, nil
  end
end

get '/api/search/tweets' do
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  from_date = params['fromDate']
  to_date = params['toDate']
  @tweets = Tweet.with_keyword(keyword)
                 .after_date(from_date)
                 .before_date(to_date)
                 .with_skip(skip)
                 .with_max(max_results)
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end

get '/api/search/users' do
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  @users = User.with_keyword(keyword)
               .with_skip(skip)
               .with_max(max_results)
  if @users
    json_response 200, @users.to_a
  else
    json_response 404, nil
  end
end
