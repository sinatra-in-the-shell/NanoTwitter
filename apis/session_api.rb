post '/api/register/?' do
  @user = User.new(email: params[:email], username: params[:username])
  @user.password = params[:password]
  if @user.save
    login @user
    status 204
  else
    status 400
    content_type :json
    @user.errors.to_json
  end
end

post '/api/login/?' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    login @user
    puts params[:remember_me]
    params[:remember_me] == '1' ? remember(@user) : forget(@user)
    status 204
  else
    halt 401, 'incorrect username or password'
  end
end

delete '/api/logout/?' do
  log_out if logged_in?
  status 204
end
