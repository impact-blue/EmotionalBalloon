class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :email
      t.string :phone
      t.integer :postal_code
      t.integer :city_id
      t.string :address
      t.string :address2

      t.timestamps null: false
    end
  end
end