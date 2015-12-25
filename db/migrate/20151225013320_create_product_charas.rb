class CreateProductCharas < ActiveRecord::Migration
  def change
    create_table :product_charas do |t|
      t.integer :product_id
      t.integer :chara_id

      t.timestamps null: false
    end
  end
end
