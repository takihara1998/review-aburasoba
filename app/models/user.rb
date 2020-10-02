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
  
  has_many :review_likes, dependent: :destroy
  has_many :goods, through: :review_likes, source: :review

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
  
  def good(review)
    self.review_likes.find_or_create_by(review_id: review.id)
  end
  
  def not_good(review)
    review_like = self.review_likes.find_by(review_id: review.id)
    review_like.destroy if review_like
  end
  
  def good_now?(review)
    self.goods.include?(review)
  end

end
