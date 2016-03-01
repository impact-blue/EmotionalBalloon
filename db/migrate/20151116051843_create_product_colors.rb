class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.integer :product_id
      t.integer :color_id

      t.timestamps null: false
    end
    add_index :product_colors,[:product_id, :color_id],unique: true
    add_index :product_colors,[:color_id, :product_id],unique: true
  end
end
