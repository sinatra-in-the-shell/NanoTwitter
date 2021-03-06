def load_seed_users(count, filenmame)
  data = CSV.read(filenmame)
  users = []
  (0..count - 1).each do |i|
    users << User.new(id: data[i][0].to_i,
                      username: data[i][1],
                      display_name: data[i][1],
                      email: Faker::Internet.unique.email,
                      password: '1234567')
  end
  User.import users
end

# add to leaders and followers buckets in corresponding redis
def load_seed_follows(count, filename)
  data = CSV.read(filename, converters: :numeric)
  data.each do |entry|
    break if entry[0] > count
    next if entry[1] > count
    begin
      Follow.create(from_user_id: entry[0], to_user_id: entry[1])
      $followers_redis&.push_single(entry[1], User.find(entry[0]))
      $leaders_redis&.push_single(entry[0], User.find(entry[1]))
    rescue
      puts 'data voilated unique follow constrain, or something wrong with redis, skkiped'
    end
  end
end

def flush_tweets_into_database(tweets, columns)
  return if tweets.empty?
  users = User.where(id: tweets.map{|t| t.user_id})
                  .map{|u|
                    [u.id, {username: u.username, display_name: u.display_name}]
                  }.to_h
  pp users
  # {1=>{:username=>"Bonnie", :display_name=>"Bonnie"},
  #  2=>{:username=>"Wilfredo", :display_name=>"Wilfredo"}}
  tweets.each{|t|
    tuser_info = users[t.user_id]
    t.username = tuser_info[:username]
    t.display_name = tuser_info[:display_name]
  }
  Tweet.import(columns, tweets)
  tweets.clear
end

def load_seed_tweets(count, filename)
  tweets = []
  columns = [
    :user_id, :text, :tweet_type,
    :created_at, :updated_at,
    :username, :display_name
  ]
  row_count = 0
  CSV.foreach(filename) do |row|
    if row[0].to_i > count
      break
    end

    tweets << Tweet.new(
      user_id: row[0].to_i,
      text: row[1],
      tweet_type: 'orig',
      created_at: row[2],
      updated_at: row[2]
    )
    row_count += 1
    # flush the array every 500 rows to limit memory usage
    if (row_count % 500).zero?
      flush_tweets_into_database(tweets, columns)
    end
  end
  flush_tweets_into_database(tweets, columns)
end

def create_test_user(count)
  testuser = User.new(
    id: count + 1,
    username: 'testuser',
    email: 'testuser@sample.com',
    display_name: 'testuser_displayname'
  )
  testuser.password = 'password'
    puts testuser.errors.messages unless testuser.save
end

def reset_all
  User.destroy_all
  Follow.destroy_all
  Tweet.destroy_all
end
