get '/api/followers' do
  @user = current_user
  redis_client = Redis.new(url: ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')

  if redis_client.exists(@user.id)
    cached = redis_client.lrange(@user.id, 0, -1)
    followers = []
    cached.each do |c|
      followers << JSON.parse(c)
    end
    json_response 200, followers
  else 
    @followers = @user.followers
    begin
      @followers.each do |f|
        redis_client.lpush(@user.id, f.to_json)
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace.inspect
    end

    if @followers
      json_response 200, @followers.to_a
    else
      json_response 404, nil
    end
  end
end

post '/api/follows' do
  @user = current_user
  @follow = Follow.new(
    from_user_id: @user.id, 
    to_user_id: params['to_user_id'])

  if @follow.save
    redis_client = Redis.new(url: ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
    redis_client.lpush(params['to_user_id'], @user.to_json)
    json_response 201, @follow
  else
    json_response 404, @follow.error_message
  end
end