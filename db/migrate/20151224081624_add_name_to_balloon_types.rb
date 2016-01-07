class AddNameToBalloonTypes < ActiveRecord::Migration
  def change
    add_column :balloon_types, :name, :string
  end
end
