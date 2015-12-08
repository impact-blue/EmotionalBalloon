class AddNumberToProducts < ActiveRecord::Migration
  def change
    add_column :products, :number, :integer
  end
end
