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
    json_response 400, nil, @user.errors.messages
  end
end

get '/api/users' do
  skip = params['skip'].to_i
  max_results = params['maxResults'].to_i
  @users = User.offset(skip).limit(max_results)
  if @users
    json_response 200, @users.to_a
  else
    json_response 404, nil
  end
end

get '/api/users/:id' do
  @user = User.find(params[:id])
  if @user
    json_response 200, @tweet.to_a
  else
    json_response 404, nil
  end
end

get '/api/users/:id/tweets' do
  @tweet = User.find(params[:id]).tweets
  if @tweet
    json_response 200, @tweet.to_a
  else
    json_response 404, nil
  end
end
