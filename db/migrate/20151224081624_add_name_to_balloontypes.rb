class AddNameToBalloontypes < ActiveRecord::Migration
  def change
    add_column :balloontypes, :name, :string
  end
end
