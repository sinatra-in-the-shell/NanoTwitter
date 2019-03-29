def login user
  puts "logging in"
  session[:user_id] = user.id
end

def remember(user)
  user.remember
  cookies[:user_id] = user.id
  cookies[:remember_token] = user.remember_token
end

def current_user
  pp '*** TESTMODE params ***:'
  pp params['test_mode']
  if (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies[:user_id])
    user = User.find_by(id: user_id)
    if user &.authenticated?(cookies[:remember_token])
      log_in user
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
  puts "logging out"
  forget(current_user)
  session.delete(:user_id)
  @current_user = nil
end
