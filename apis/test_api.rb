# Test Interfaces

get '/test/status' do
  erb :status,
      locals: {
        test_id: User.find(email: "testuser@sample.com").id,
        user_count: User.count,
        follow_count: Follow.count,
        tweet_count: Tweet.count
      }
end

# If needed deletes all users, tweets, follows
# Recreates TestUser
# Example: test/reset/all
post '/test/reset/all' do
  reset_all
  create_test_user 0
  status 200, OK
end

# Deletes all users, tweets and follows
# Recreate TestUser
# Imports data from standard seed data
post '/test/reset' do
  user_num = params[:users].to_i
  if user_num.nil?
    halt 400, "no user count specified."
  else
    reset_all
    seed_file_path = './db/seed/'
    load_seed_users(user_num, seed_file_path + 'users.csv')
    load_seed_follows(user_num, seed_file_path + 'follows.csv')
    load_seed_tweets(user_num, seed_file_path + 'tweets.csv')
    create_test_user(user_num)
    status 200, OK
  end
end

# POST /test/user/{u}/tweets?count=n
# {u} can be the user id of some user, or the keyword testuser
# n is how many randomly generated tweets are submitted on that users behalf
post '/test/user/:userid/tweets' do
  print 'userid = ', params['userid'], ' count = ', params['count'], "\n"
  import_tweets(params['userid'].to_i, params['count'].to_i)
  status 200, OK
end
