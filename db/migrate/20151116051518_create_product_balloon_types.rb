class CreateProductBalloonTypes < ActiveRecord::Migration
  def change
    create_table :product_balloon_types do |t|
      t.integer :product_id
      t.integer :balloon_type_id

      t.timestamps null: false
    end
  end
end
