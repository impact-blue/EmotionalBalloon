class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :city
      t.string :payment_info
      t.date :order_date
      t.string :delivery_address
      t.string :delivery_address2
      t.string :option
      t.integer :scene_id
      t.string :order_status
      t.integer :price
      t.integer :postage

      t.timestamps null: false
    end
  end
end
