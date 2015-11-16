class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :character

      t.timestamps null: false
    end
  end
end
