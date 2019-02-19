class Hashtag < ActiveRecord::Base
  has_many :tweets_hashtags_relationships
  has_many :tweets, through: :tweets_hashtags_relationships
end
