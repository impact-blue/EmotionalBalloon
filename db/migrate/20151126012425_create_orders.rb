class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :postal_code
      t.string  :city
      t.string  :delivery_address
      t.integer :phone
      t.date    :order_date
      t.string  :payment_info
      t.string  :option
      t.integer :scene_id
      t.string  :order_status
      t.integer :price

      t.timestamps null: false
    end
  end
end
