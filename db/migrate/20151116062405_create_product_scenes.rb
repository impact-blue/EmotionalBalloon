class CreateProductScenes < ActiveRecord::Migration
  def change
    create_table :product_scenes do |t|
      t.integer :product_id
      t.integer :scene_id
      t.integer :status

      t.timestamps null: false
    end
  end
end