get '/api/search/tags' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  from_date = params['fromDate']
  to_date = params['toDate']
  @tags = Tag.where("name LIKE ?", "%#{keyword}%")
             .offset(skip).limit(max_results)
             .where(
               "created_at > ? AND created_at < ?",
               DateTime.new(from_date),
               DateTime.new(to_date)
             ).to_json
end

get '/api/search/tweets' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  from_date = params['fromDate']
  to_date = params['toDate']
  @tweets = Tweet.where("name LIKE ?", "%#{keyword}%")
                 .offset(skip).limit(max_results)
                 .where(
                   "created_at > ? AND created_at < ?",
                   DateTime.new(from_date),
                   DateTime.new(to_date)
                 ).to_json
end

get '/api/search/users' do
  keyword = params['keyword']
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  @tweets = Tweet.where("name LIKE ?", "%#{keyword}%")
                 .offset(skip).limit(max_results).to_json
end
