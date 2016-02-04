class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.integer :price
      t.integer :stocks
      t.text    :comment
      t.text    :keyword
      t.integer :boxsize_id
      t.integer :count
      t.integer :status

      t.timestamps null: false
    end
  end
end
