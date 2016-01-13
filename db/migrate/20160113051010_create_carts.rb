class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :ip
      t.integer :product_id
      t.integer :flag

      t.timestamps null: false
    end
  end
end
