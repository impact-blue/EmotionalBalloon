class CreateBalloontypes < ActiveRecord::Migration
  def change
    create_table :balloontypes do |t|
      t.string :balloontype

      t.timestamps null: false
    end
  end
end
