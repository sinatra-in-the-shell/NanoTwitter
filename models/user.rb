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
end
