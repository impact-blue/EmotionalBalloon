class CreateUserNames < ActiveRecord::Migration
  def change
    create_table :user_names do |t|
      t.integer :user_id
      t.string :user_family_name
      t.string :user_first_name

      t.timestamps null: false
    end
    add_index :user_names, :user_id
  end
end
