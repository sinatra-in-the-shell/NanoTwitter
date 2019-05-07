class FollowHelper

  def initialize
  end

  def process req
    case req['method']
    when 'followings'
      followings req['args']
    when 'followers'
      followers req['args']
    else
      'Unknown method'
    end
  end

  private

    def followers args
      user = User.find args['user_id'].to_i

      if $followers_redis.cached?(user.id)
        begin
          @followers = $followers_redis.get_json_list(user.id, 0, -1)
        rescue StandardError => e
          return rabbit_response 500, nil, e.message
        end
      else
        @followers = user.followers
        if @followers
          $followers_redis.push_results(user.id, @followers)
        end
      end
      if @followers
        rabbit_response 200, @followers
      else
        rabbit_response 404, nil, 'not found'
      end
    end

    def followings args
      user = User.find args['user_id'].to_i
      @followings = user.followings
      if @followings
        rabbit_response 200, @followings
      else
        rabbit_response 404, nil, 'not found'
      end
    end
end
