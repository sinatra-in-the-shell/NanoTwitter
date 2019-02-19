class Tweet < ActiveRecord::Base
  belongs_to :user

  has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_from_id'
  has_many :comments, class_name: 'Tweet', foreign_key: 'comment_to_id'

  validates :user_id, presence: true
  validates :text, presence: true
  validates :tweet_type, presence: true
end
