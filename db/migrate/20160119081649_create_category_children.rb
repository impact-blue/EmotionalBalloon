class CreateCategoryChildren < ActiveRecord::Migration
  def change
    create_table :category_children do |t|
      t.string :name
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
