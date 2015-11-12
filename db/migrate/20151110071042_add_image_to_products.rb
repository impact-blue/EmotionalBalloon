class AddImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image, :string
    add_column :products, :price, :integer
  end
end
