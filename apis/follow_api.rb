get '/api/followers/?' do
  user = current_user

  if $friendship_redis.cached?(user.id)
    begin
      timeline = $friendship_redis.get_json_list(user.id, 0, -1)
      json_response 200, timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  else 
    @followers = user.followers
    begin
      $friendship_redis.push_results(user.id, @followers)
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
    $friendship_redis.push_single(params['to_user_id'], user)
    json_response 200, @follow
  else
    json_response 404, @follow.error.full_messages
  end
end