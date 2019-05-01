class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 200}}
  validates :user_id,{presence: true}
  mount_uploaders :picture, PictureUploader
  serialize :picture, JSON
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments
  
  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      all
    end
  end
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  def like(user)
    likes.create(user_id: user.id)
  end
  
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def like?(user)
    like_users.include?(user)
  end
  def comment(user)
    comments.create(user_id: user.id)
  end
    
end
