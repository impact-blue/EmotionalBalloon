class RenameCharacterColumsToCharacters < ActiveRecord::Migration
  def change
     rename_column :characters, :character, :chara
  end
end
