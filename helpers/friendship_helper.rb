# def get_leaders_ids(user_id)
#   if $leaders_redis.cached? user_id
#     leaders = $leaders_redis.get_json_list(user_id, 0, -1)
#     leaders.map { |l| l['id'] }
#   else 
#     user = User.find(user_id)
#     user.following
#   end
# end

# def get_followers_ids(user_id)
#   if $followers_redis.cached? user_id
#     followers = $followers_redis.get_json_list(user_id, 0, -1)
#     followers.map { |f| f['id'] }
#   else 
#     # nil
#   end
# end