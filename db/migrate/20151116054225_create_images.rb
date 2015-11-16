class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :product_id
      t.integer :image_id

      t.timestamps null: false
    end
  end
end
