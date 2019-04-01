def load_seed_users(count, filenmame)
  data = CSV.read(filenmame)
  users = []
  (0..count - 1).each do |i|
    users << User.new(id: data[i][0].to_i,
                      username: data[i][1],
                      email: Faker::Internet.unique.email,
                      password: '1234567')
  end
  User.import users
end

def load_seed_follows(count, filename)
  data = CSV.read(filename, converters: :numeric)
  data.each do |entry|
    break if entry[0] > count
    next if entry[1] > count
    begin
      Follow.create(from_user_id: entry[0], to_user_id: entry[1])
      redis_client = RedisClient.new(ENV['HEROKU_REDIS_COBALT_URL'] || 'redis://localhost:6380')
      redis_client.push_single(entry[1], User.find(entry[0]))
    rescue
      puts 'data voilated unique follow constrain, skiped'
    end
  end
end

def load_seed_tweets(count, filename)
  data = CSV.read(filename)
  tweets = []
  columns = [:user_id, :text, :tweet_type, :created_at, :updated_at]
  data.each do |entry|
    break if entry[0].to_i > count

    tweets << Tweet.new(
      user_id: entry[0].to_i,
      text: entry[1],
      tweet_type: 'orig',
      created_at: entry[2],
      updated_at: entry[2]
    )
  end
  Tweet.import(columns, tweets)
end

def create_test_user(count)
  testuser = User.new(
    id: count + 1,
    username: 'testuser',
    email: 'testuser@sample.com'
  )
  testuser.password = 'password'
  if !testuser.save
    puts testuser.errors.message
  end
end

def reset_all
  User.destroy_all
  Follow.destroy_all
  Tweet.destroy_all
end
