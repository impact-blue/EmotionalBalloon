class ChangePhoneToUsers < ActiveRecord::Migration
  def up
    change_column :Users,:phone, :string
  end

  def down
    change_column :Users, :phone, :integer
  end
end
