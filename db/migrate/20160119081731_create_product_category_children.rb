class CreateProductCategoryChildren < ActiveRecord::Migration
  def change
    create_table :product_category_children do |t|
      t.integer :product_id
      t.integer :category_chird_id

      t.timestamps null: false
    end
  end
end
