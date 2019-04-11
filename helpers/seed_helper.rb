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
      $followers_redis.push_single(entry[1], User.find(entry[0]))
    rescue
      puts 'data voilated unique follow constrain, skiped'
    end
  end
end

# TODO: seed fanout

def load_seed_tweets(count, filename)
  data = CSV.read(filename)
  tweets = []
  columns = [:user_id, :text, :tweet_type, :created_at, :updated_at]
  author_ids = []
  data.each do |entry|
    break if entry[0].to_i > count
    tweets << Tweet.new(
      user_id: entry[0].to_i,
      text: entry[1],
      tweet_type: 'orig',
      created_at: entry[2],
      updated_at: entry[2]
    )
    author_ids << entry[0].to_i
  end
  r = Tweet.import(columns, tweets)
  imported_tweets = Tweet.find(r.ids)

  # TODO: fanout
  imported_tweets.each do |it|
    pp "fanout with author_id: #{it.user_id}, tweet_id: #{it.id}"
  end
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