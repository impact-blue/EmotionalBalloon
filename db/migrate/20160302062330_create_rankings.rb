class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :product_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
