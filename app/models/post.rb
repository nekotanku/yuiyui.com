class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id,{presence: true}
  mount_uploaders :picture, PictureUploader
  serialize :picture, JSON
  def user
    return User.find_by(id: self.user_id)
  end
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :delete_all
  def like(user)
    likes.create(user_id: user.id)
  end
  
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  def like?(user)
    like_users.include?(user)
  end
  
end
