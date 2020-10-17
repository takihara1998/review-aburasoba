class AddShopPictureToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :shop_picture, :string
  end
end
