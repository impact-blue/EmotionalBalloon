class CreateProductCharacters < ActiveRecord::Migration
  def change
    create_table :product_characters do |t|
      t.integer :product_id
      t.integer :character_id

      t.timestamps null: false
    end
  end
end
