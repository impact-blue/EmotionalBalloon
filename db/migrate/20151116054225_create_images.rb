class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :product_id
      t.string :color
      t.binary :image, limit: 10.megabyte
      t.string :image_content_type

      t.timestamps null: false
    end
    add_index :images,:product_id
  end
end