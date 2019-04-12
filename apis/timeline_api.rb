get '/api/timeline/?' do
  user = current_user
  limit = params['limit'] || 50

  if $timeline_redis.cached?(user.id)
    begin
      timeline = $timeline_redis.get_json_list(user.id, 0, -1)
      json_response 200, timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  else 
    @timeline = get_timeline(user.id, limit)
    return if params['uncached']
    begin
      $timeline_redis.push_results(user.id, @timeline)
      json_response 200, @timeline
    rescue StandardError => e
      json_response 400, e.message
    end
  end
end


# OLD SQL for timeline when services are not separated
    # @timeline = Tweet.find_by_sql(["
    #   SELECT DISTINCT tweets.*
    #   FROM tweets, follows
    #   WHERE
    #     follows.from_user_id = ? AND
    #     (tweets.user_id = follows.to_user_id OR
    #     tweets.user_id = ?)
    #   ORDER BY tweets.updated_at DESC
    #   LIMIT ?
    # ", user.id, user.id, limit])
