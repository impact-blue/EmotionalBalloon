class CreateProductBalloontypes < ActiveRecord::Migration
  def change
    create_table :product_balloontypes do |t|
      t.integer :product_id
      t.integer :balloontype_id

      t.timestamps null: false
    end
  end
end
