def search_tag_from_database(params)
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  from_date = params['fromDate']
  to_date = params['toDate']
  tags = Hashtag.with_keyword(keyword)
                .after_date(from_date)
                .before_date(to_date)
                .with_skip(skip)
                .with_max(max_results)
  puts "[REDIS MISS] searched tags by #{keyword}"
  if tags
    $search_redis.push_results(keyword + '_tags', tags)
    $search_redis.expire(keyword + '_tags', 10)
    json_response 200, tags
  else
    json_response 404, nil, 'not found'
  end
end

def search_tweet_from_database(params)
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  from_date = params['fromDate']
  to_date = params['toDate']
  tweets = Tweet.with_keyword(keyword)
                .after_date(from_date)
                .before_date(to_date)
                .with_skip(skip)
                .with_max(max_results)
                .reorder(created_at: :desc)
  pp tweets
  puts "[REDIS MISS] searched tweets by #{keyword}"
  puts "[DATABASE RESULT] got result:"
  if tweets
    result = tweets.as_json(include:
      {
        user: { only: [:username, :display_name] }
      }
    )
    $search_redis.push_results(keyword + '_tweets', result)
    $search_redis.expire(keyword + '_tweets', 20)
    json_response 200, result
  else
    json_response 404, nil, 'not founbd'
  end
end

def search_user_from_database(params)
  keyword = params['keyword']
  skip = params['skip']
  max_results = params['maxresults']
  users = User.with_keyword(keyword)
              .with_skip(skip)
              .with_max(max_results)
  puts "[REDIS MISS] searched users by #{keyword}"
  if users
    $search_redis.push_results(keyword + '_users', users)
    $search_redis.expire(keyword + '_users', 10)
    json_response 200, users
  else
    json_response 404, nil, 'not found'
  end
end

def get_cache_from_search_redis(keyword, max_results)
  puts "[REDIS HIT] searched #{keyword}"
  begin
    res = $search_redis.get_json_list(keyword, 0, max_results - 1)
    json_response 200, res
  rescue StandardError => e
    json_response 400, e.message
  end
end
