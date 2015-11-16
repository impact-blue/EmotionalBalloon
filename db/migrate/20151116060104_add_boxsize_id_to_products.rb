class AddBoxsizeIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :boxsize_id, :integer
  end
end
