class CreateCharas < ActiveRecord::Migration
  def change
    create_table :charas do |t|
      t.string :chara
      t.string :name

      t.timestamps null: false
    end
  end
end