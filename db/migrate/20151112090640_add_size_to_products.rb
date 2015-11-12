class AddSizeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :stocks, :integer
    add_column :products, :postage, :integer
    add_column :products, :comment, :text
    add_column :products, :keyword, :text
    add_column :products, :recommended, :text
    add_column :products, :registration_date, :date
  end
end
