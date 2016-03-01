class CreateOrderProductInfos < ActiveRecord::Migration
  def change
    create_table :order_product_infos do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :count

      t.timestamps null: false
    end
    add_index :order_product_infos,[:product_id, :order_id],unique: true
    add_index :order_product_infos,[:order_id, :product_id],unique: true
  end
end