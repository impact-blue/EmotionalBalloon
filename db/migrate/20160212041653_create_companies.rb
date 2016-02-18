class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :postal_code
      t.string :address
      t.string :phone
      t.string :ceo
      t.string :foundation_day
      t.string :capital
      t.string :trade_name
      t.string :proper
      t.string :special_price
      t.string :cancel_info
      t.string :payment_info

      t.timestamps null: false
    end
  end
end
