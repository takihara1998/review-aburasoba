class CreateShopLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_likes do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :shop_id], unique: true
    end
  end
end
