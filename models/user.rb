class User < ActiveRecord::Base
  # attr
  attr_accessor :remember_token

  # validation
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  # relations
  has_many :active_relationships, class_name: 'Follow',
           foreign_key: 'from_user_id',
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :to_user

  has_many :passive_relationships, class_name: 'Follow',
           foreign_key: 'to_user_id',
           dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :from_user

  has_many :tweets
  has_many :likes

  has_many :received_notifications, class_name: 'Notification', foreign_key: 'to_user_id'
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'from_user_id'

  # scopes
  scope :with_keyword, lambda { |keyword|
    unless keyword.nil?
      where("username LIKE ? or display_name LIKE ?", "%#{keyword}%", "%#{keyword}%")
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

  # utils
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # methods
  def to_json
    super(except: :password)
  end

  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, BCrypt::Password.create(remember_token)
  end

  def forget
    return false if remember_digest.nil?
    self.remember_token = nil
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest) == remember_token
  end
end
