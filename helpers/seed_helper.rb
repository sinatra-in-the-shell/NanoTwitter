require 'csv'

def load_seed_users(count, filenmame)
  data = CSV.read(filenmame)
  1..count.each do |i|
    User.create(id: data[i][0].to_i, username: data[i][1], email: Faker::Internet.unique.email)
  end
end

def load_seed_follows(count, filename)
  data = CSV.read(filename, converters: :numeric)
  data.each do |entry|
    break if entry[0] > count
    next if entry[1] > count

    user1 = User.find_by_id(entry[0])
    user2 = User.find_by_id(entry[1])
    user1.follow(user2)
  end
end

def load_tweets(count, filename)
  data = CSV.read(filename)
  data.each do |entry|
    break if entry[0].to_i > count

    Tweet.create(
      user_id: entry[0].to_i,
      text: entry[1],
      created_at: entry[2],
      updated_at: entry[2]
    )
  end
end

def create_test_user
  testuser = User.new(
    name: 'testuser',
    email: 'testuser@sample.com'
  )
  testuser.password = 'password'
  testuser.save!
end

def reset_all
  User.destroy_all
  Tweet.destroy_all
end
