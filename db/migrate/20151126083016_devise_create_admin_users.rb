class DeviseCreateAdminUsers < ActiveRecord::Migration
  def change
    create_table(:admin_users) do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :admin_users, :email, unique: true
  end
end
