
#About fulltext search: https://www.postgresql.org/docs/10/textsearch-indexes.html

get '/api/search/tags' do
  @keyword = params['keyword'] + '_tags'
  @max_results = params['maxresults'].to_i
  if $search_redis&.cached?(@keyword)
    get_cache_from_search_redis(@keyword, @max_results)
  else
    search_tag_from_database(params)
  end
end

get '/api/search/tweets' do
  @keyword = params['keyword'] + '_tweets'
  @max_results = params['maxresults'].to_i
  if params['service']=='yes'
    res = tweet_client.call(
      method: 'search_tweets',
      args: params.to_h
    )
    return json_response res['status'], res['data'], res['errors']
  end
  if $search_redis&.cached?(@keyword)
    get_cache_from_search_redis(@keyword, @max_results)
  else
    search_tweet_from_database(params)
  end
end

get '/api/search/users' do
  @keyword = params['keyword'] + '_users'
  @max_results = params['maxresults'].to_i
  if $search_redis&.cached?(@keyword)
    get_cache_from_search_redis(@keyword, @max_results)
  else
    search_user_from_database(params)
  end
end
