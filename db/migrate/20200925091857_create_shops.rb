class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :picture
      t.string :address
      t.string :open_hour
      t.string :tel
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
