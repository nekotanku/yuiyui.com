class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id,{presence: true}
  def user
    return User.find_by(id: self.user_id)
  end
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  
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
