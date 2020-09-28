class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.string :title
      t.text :content
      t.string :picture_a
      t.string :picture_b
      t.float :star

      t.timestamps
    end
  end
end
