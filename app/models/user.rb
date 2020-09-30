class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # validates :picture　???
  validates :introduction, length: { maximum: 255 }
  has_secure_password
  
  has_many :shops
  has_many :reviews, dependent: :destroy
  
  has_many :shop_likes, dependent: :destroy
  has_many :likes, through: :shop_likes, source: :shop

  def like(shop)
    self.shop_likes.find_or_create_by(shop_id: shop.id)
  end
  
  def unlike(shop)
    shop_like = self.shop_likes.find_by(shop_id: shop.id)
    shop_like.destroy if shop_like
  end
  
  def liking?(shop)
    self.likes.include?(shop)
  end

end
