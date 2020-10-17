class RemovePictureFromShops < ActiveRecord::Migration[5.2]
  def change
    remove_column :shops, :picture, :string
  end
end
