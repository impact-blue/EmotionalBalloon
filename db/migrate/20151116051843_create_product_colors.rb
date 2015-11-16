class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.integer :product_id
      t.integer :color_id

      t.timestamps null: false
    end
  end
end
