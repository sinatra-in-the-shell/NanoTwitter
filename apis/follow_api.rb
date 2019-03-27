get '/api/followers' do
  #if current_user and params['user_id'] not valid, will give 500
  @user = current_user || User.find(params['user_id'])
  @followers = nil

  friendship_redis = Redis.new(url: ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
  cached = friendship_redis.lrange(@user.id, 0, -1)

  if cached
    pp '*** GET ITEM FROM REDIS CACHE ***'
    @followers = []
    cached.each do |c|
      @followers << JSON.parse(c)
    end
    json_response 200, @followers
  end

  @followers = @user.followers
  if @followers
    json_response 200, @followers.to_a
  else
    json_response 404, nil
  end
end

post '/api/follows' do
  @user = current_user || User.find(params['user_id'])
  @follow = Follow.new(from_user_id: @user.id, to_user_id: params['to_user_id'])
  @followed = User.find(params['user_id'])

  if @follow.save
    redis_client = Redis.new(url: ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
    redis_client.lpush(@user.id, @followed.to_json)
    pp redis_client.lrange(@user.id, 0, -1)
    json_response 201, @follow
  else
    json_response 404, @follow.error_message
  end
end