class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_ja
      t.string :genre
      t.integer :status

      t.timestamps null: false
    end
  end
end
