class RenameCharactersToCharas < ActiveRecord::Migration
  def change
     rename_table :characters, :charas
  end
end
