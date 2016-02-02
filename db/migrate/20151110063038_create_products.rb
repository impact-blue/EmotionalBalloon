class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :price
      t.integer :stocks
      t.integer :postage
      t.text    :comment
      t.text    :keyword
      t.date    :registration_date
      t.integer :boxsize_id

      t.timestamps null: false
    end
  end
end
