class AddNameToColors < ActiveRecord::Migration
  def change
    add_column :colors, :name, :string
  end
end
