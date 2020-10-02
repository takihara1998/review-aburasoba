class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  # validates :picture_a  ???
  # validates :picture_b  ???
  validates :star, presence: true
  
  has_many :review_likes, dependent: :destroy
  has_many :users, through: :review_likes

end
