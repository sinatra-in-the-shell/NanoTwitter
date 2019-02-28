require 'bcrypt'
class User < ActiveRecord::Base
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
end
