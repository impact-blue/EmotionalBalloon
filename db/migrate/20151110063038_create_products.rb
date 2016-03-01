class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :price
      t.integer :stocks
      t.binary :main_image, limit: 10.megabyte
      t.string :main_image_content_type
      t.text    :comment
      t.text    :keyword
      t.integer :size
      t.integer :count
      t.integer :category_id
      t.integer :status

      t.timestamps null: false
    end
    add_index :products, :category_id
  end
end
