class CreateCategoryChildren < ActiveRecord::Migration
  def change
    create_table :category_children do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
