class RenameCharaIdColumsToProductCharas < ActiveRecord::Migration
  def change
    rename_column :product_charas, :character_id, :chara_id
  end
end
