class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.integer :postal_code
      t.string :city
      t.string :address

      t.timestamps null: false
    end
  end
end