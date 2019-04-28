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
      user = User.find args['id'].to_i

      if $followers_redis.cached?(user.id)
        begin
          @followers = $followers_redis.get_json_list(user.id, 0, -1)
          @followers.to_json
        rescue StandardError => e
          e.message
        end
      else
        @followers = user.followers
        begin
          $followers_redis.push_results(user.id, @followers)
          @followers.to_json
        rescue StandardError => e
          e.message
        end
      end
    end

    def followings args
      user = User.find args['id'].to_i
      @followings = user.followings
      @followings.to_json
    end
end
