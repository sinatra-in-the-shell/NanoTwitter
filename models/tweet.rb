class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :retweet_from, class_name: 'Tweet', foreign_key: 'retweet_from_id'

  has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_from_id'
  has_many :comments, class_name: 'Tweet', foreign_key: 'comment_to_id'

  has_many :likes

  has_many :tweets_hashtags_relationships
  has_many :hashtags, through: :tweets_hashtags_relationships

  # scopes
  scope :with_keyword, lambda { |keyword|
    unless keyword.nil?
      basic_search(text: keyword)
    end
  }
  scope :with_skip, lambda { |skip|
    unless skip.nil?
      offset(skip.to_i)
    end
  }
  scope :with_max, lambda { |max|
    unless max.nil?
      limit(max.to_i)
    end
  }
  scope :before_date, lambda { |date|
    unless date.nil?
      where("created_at < ?", DateTime.new(date))
    end
  }
  scope :after_date, lambda { |date|
    unless date.nil?
      where("created_at > ?", DateTime.new(date))
    end
  }

  validates :user_id, presence: true
  validates :text, presence: true
  validates :tweet_type, presence: true

  def self.searchable_columns
    [:text]
  end
end
