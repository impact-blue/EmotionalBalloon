class CreateTraderules < ActiveRecord::Migration
  def change
    create_table :traderules do |t|
      t.string :company
      t.string :supervisor
      t.string :postal_code
      t.string :address
      t.string :phone
      t.string :business_hours
      t.string :mail
      t.string :homepage
      t.string :price
      t.string :special_price
      t.string :payment_info
      t.string :delivery_deadline
      t.string :cancel_info

      t.timestamps null: false
    end
  end
end
