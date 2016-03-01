class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :price
      t.string :postal_code
      t.string  :city
      t.string  :delivery_address
      t.string  :payment_info
      t.string  :order_status
      t.string :phone
      t.string  :option
      t.integer :category

      t.date    :order_date
      t.timestamps null: false
    end
    add_index :orders, :user_id
  end
end
