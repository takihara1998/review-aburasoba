class Shop < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  # validates :picture  ???
  validates :address, presence: true, length: { maximum: 255 }
  validates :open_hour, length: { maximum: 50 }
  validates :holiday, length: { maximum: 50 }
  validates :tel, length: { maximum: 50 }


end
