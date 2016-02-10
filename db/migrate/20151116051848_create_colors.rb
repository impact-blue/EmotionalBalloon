class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name_en
      t.string :name_ja

      t.timestamps null: false
    end
  end
end
