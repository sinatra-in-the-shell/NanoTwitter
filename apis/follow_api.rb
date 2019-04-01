get '/api/followers/?' do
  user = current_user
  redis_client = RedisClient.new(ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
  if redis_client.cached?(user.id)
    begin
      timeline = redis_client.get_json_list(user.id, 0, -1)
      json_response 200, timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  else 
    @followers = user.followers
    begin
      redis_client.push_results(user.id, @followers)
      json_response 200, @followers.to_a
    rescue StandardError => e
      json_response 400, e.message
    end
  end
end

get '/api/followers/uncached?' do
  user = current_user
  @followers = user.followers
  if @followers
    json_response 200, @followers.to_a
  else 
    json_response 400, e.message
  end
end

post '/api/follows/?' do
  user = current_user
  @follow = Follow.new(
    from_user_id: user.id, 
    to_user_id: params['to_user_id'])
  if @follow.save
    redis_client = RedisClient.new(ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
    redis_client.push_single(params['to_user_id'], user)
    json_response 200, @follow
  else
    json_response 404, @follow.error.full_messages
  end
end