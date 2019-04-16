get '/api/follows/followers/uncached/?' do
  user = current_user
  @followers = user.followers
  if @followers
    json_response 200, @followers.to_a
  else
    json_response 404, 'not found'
  end
end

get '/api/follows/followers/?' do
  user = current_user

  if $friendship_redis.cached?(user.id)
    begin
      followers = $friendship_redis.get_json_list(user.id, 0, -1)
      json_response 200, followers
    rescue StandardError => e
      json_response 404, e.message
    end
  else
    @followers = user.followers
    begin
      $friendship_redis.push_results(user.id, @followers)
      json_response 200, @followers.to_a
    rescue StandardError => e
      json_response 404, e.message
    end
  end
end

get '/api/follows/followings/?' do
  user = current_user
  @followings = user.followings
  if @followings
    json_response 200, @followings.to_a
  else
    json_response 404, 'not found'
  end
end

post '/api/follows/?' do
  user = current_user
  @follow = Follow.new(
    from_user_id: user.id,
    to_user_id: params['to_user_id']
  )
  if @follow.save
    # $friendship_redis.push_single(params['to_user_id'], user)
    json_response 200, @follow
  else
    json_response 400, nil, @follow.errors.full_messages
  end
end

delete '/api/follows/?' do
  user = current_user
  @follow = Follow.find_by(
    from_user_id: user.id,
    to_user_id: params['to_user_id']
  )
  if @follow
    if @follow.destroy
      json_response 200, @follow
    else
      json_response 400
    end
  else
    json_response 404, nil, 'not found'
  end
end
