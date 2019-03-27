get '/api/followers' do
  @user = current_user || User.find(params['user_id'])
  @followers = @user.followers

  pp @followers
  if @followers
    json_response 200, @followers.to_a
  else
    json_response 404, nil
  end
end

post '/api/follows' do
  @user = current_user || User.find(params['user_id'])
  @follow = Follow.new(from_user_id: @user.id, to_user_id: params['to_user_id'])

  if @follow.save
    json_response 201, @follow
  else
    json_response 404, @follow.error_message
  end
end