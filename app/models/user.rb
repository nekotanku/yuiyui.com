class User < ApplicationRecord
  before_save { self.email.downcase! }
  has_secure_password
  
  validates :name, presence: true,
                   length: { in: 3..20 }, 
                   uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  def posts
    return Post.where(user_id: self.id)
  end
end
