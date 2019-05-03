class User < ApplicationRecord
  before_save { self.email.downcase! }
  has_secure_password
  validates :name, presence: true,
                   length: { in: 3..20 }, 
                   uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduce, length: { maximum: 200 }
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship,  source: :user
  has_many :comments
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship =self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
