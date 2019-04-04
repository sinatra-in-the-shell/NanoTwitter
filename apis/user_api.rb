get '/api/users/?' do
  skip = params['skip']
  max_results = params['maxresults']
  @users = User.with_skip(skip).with_max(max_results)
  if @users
    json_response 200, @users.to_a
  else
    json_response 404, nil
  end
end

get '/api/users/:id/?' do
  @user = (params[:id]=='current') ?
    current_user : User.find(params[:id])
  if @user
    json_response 200, @user
  else
    json_response 404, nil
  end
end

get '/api/users/:id/tweets/?' do
  @tweets = User.find(params[:id]).tweets
  if @tweets
    json_response 200, @tweets.to_a
  else
    json_response 404, nil
  end
end
