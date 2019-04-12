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

get '/api/users/:username/?' do
  @user = (params[:username]=='i') ?
    current_user : User.find_by(username: params[:username])
  if @user
    json_response 200, @user.as_json(
      methods: [
        :follower_number,
        :following_number,
        :tweet_number
      ]
    )
  else
    json_response 404, nil
  end
end

get '/api/users/:username/tweets/?' do
  @tweets = User.find_by(username: params[:username]).tweets
  if @tweets
    json_response 200, @tweets.as_json(include:
      {
        user: { only: [:username, :display_name] }
      }
    )
  else
    json_response 404, nil
  end
end
