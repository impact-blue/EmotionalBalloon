class CreateOrderDeliveryNames < ActiveRecord::Migration
  def change
    create_table :order_delivery_names do |t|
      t.integer :order_id
      t.string :order_family_name
      t.string :order_first_name

      t.timestamps null: false
    end
  end
end
