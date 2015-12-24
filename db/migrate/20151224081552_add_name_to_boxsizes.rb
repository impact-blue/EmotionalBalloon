class AddNameToBoxsizes < ActiveRecord::Migration
  def change
    add_column :boxsizes, :name, :string
  end
end
