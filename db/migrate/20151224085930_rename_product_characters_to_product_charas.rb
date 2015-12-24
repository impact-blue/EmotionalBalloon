class RenameProductCharactersToProductCharas < ActiveRecord::Migration
  def change
    rename_table :product_characters, :product_charas
  end
end
