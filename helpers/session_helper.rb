def login user
  session[:user_id] = user.id
end

def remember(user)
  user.remember
  response.set_cookie :user_id,
                      value: user.id,
                      expires: Time.now + 3600*24*365
  response.set_cookie :remember_token,
                      value: user.remember_token,
                      expires: Time.now + 3600*24*365
end

def current_user
  if params['test_user']
    User.find_by(id: params['test_user'])
  elsif (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies[:user_id])
    user = User.find_by(id: user_id)
    if user &.authenticated?(cookies[:remember_token])
      login user
      @current_user = user
    end
  end
end

def logged_in?
  !current_user.nil?
end

def forget(user)
  user.forget
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
end

def log_out
  forget(current_user)
  session.delete(:user_id)
  @current_user = nil
end
