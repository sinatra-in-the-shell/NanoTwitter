class Hashtag < ActiveRecord::Base
  has_many :tweets_hashtags_relationships
  has_many :tweets, through: :tweets_hashtags_relationships

  # scopes
  scope :with_keyword, lambda { |keyword|
    unless keyword.nil?
      where("name LIKE ?", "%#{keyword}%")
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
end
