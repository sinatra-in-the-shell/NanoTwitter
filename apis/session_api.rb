post '/api/register/?' do
  @user = User.new(email: params[:email], username: params[:username])
  @user.password = params[:password]
  if @user.save
    login @user
    json_response 200
  else
    json 400, nil, @user.errors.full_messages
  end
end

post '/api/login/?' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    login @user
    params[:remember_me] == "true" ? remember(@user) : forget(@user)
    return json_response 200
  else
    json_response 401, nil, 'incorrect username or password'
  end
end

delete '/api/logout/?' do
  log_out if logged_in?
  json_response 200
end
