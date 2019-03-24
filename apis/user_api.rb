post '/api/users' do
  @user = User.new(
    username: params['username'],
    email: params['email'],
    display_name: params['display_name'],
    region: params['region'],
    date_of_birth: params['date_of_birth'],
    bio: params['bio']
  )
  @user.password = params['password']
  if @user.save
    login @user
    remember @user
    json_response 201, nil
  else
    json_response 400, nil, @user.errors.full_messages
  end
end

get '/api/users' do
  skip = params['skip']
  max_results = params['maxresults']
  @users = User.with_skip(skip).with_max(max_results)
  if @users
    json_response 200, @users.to_a
  else
    json_response 404, nil
  end
end

get '/api/users/:id' do
  @user = User.find(params[:id])
  if @user
    json_response 200, @user
  else
    json_response 404, nil
  end
end

get '/api/users/:id/tweets' do
  @tweets = User.find(params[:id]).tweets
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end


get '/api/user/timeline' do
  @user = current_user
end
