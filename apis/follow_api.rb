get '/api/followers/?' do
  user = current_user

  if $followers_redis.cached?(user.id)
    begin
      followers = $followers_redis.get_json_list(user.id, 0, -1)
      json_response 200, followers
    rescue StandardError => e
      json_response 400, e.message
    end
  else 
    @followers = user.followers
    begin
      $followers_redis.push_results(user.id, @followers)
      json_response 200, @followers.to_a
    rescue StandardError => e
      json_response 400, e.message
    end
  end
end

get '/api/followers/uncached/?' do
  user = current_user
  @followers = user.followers
  if @followers
    json_response 200, @followers.to_a
  else 
    json_response 400, e.message
  end
end

post '/api/follows/?' do
  from_user = current_user
  to_user = User.find(params['to_user_id'])
  @follow = Follow.new(
    from_user_id: from_user.id,
    to_user_id: to_user.id)
  if @follow.save
    $followers_redis.push_single(to_user.id, from_user)
    $leaders_redis.push_single(from_user.id, to_user)
    json_response 200, @follow
  else
    json_response 404, @follow.error.full_messages
  end
end