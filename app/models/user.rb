class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }

  has_secure_password

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: Relationship, foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :microposts
  has_many :likes
  has_many :like_microposts, through: :likes, source: :micropost

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

  def like(micropost)
    unless like?(micropost)
      self.likes.find_or_create_by(micropost_id: micropost.id)
    end
  end

  def unlike(micropost)
    likes = self.likes.find_by(micropost_id: micropost.id)
    likes.destroy if likes
  end

  def like?(micropost)
    (self.likes.find_by(micropost_id: micropost.id)) ? true : false
  end

  def feed_likes
    Micropost.where(id: likes.micropost_id)
  end
end
