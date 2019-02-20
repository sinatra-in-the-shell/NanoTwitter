class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates :user_id, presence: true
  validates :tweet_id, presence: true

  #TODO: user_id, tweet_id uniqueness check
end
