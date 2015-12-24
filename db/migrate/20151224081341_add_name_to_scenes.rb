class AddNameToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :name, :string
  end
end
