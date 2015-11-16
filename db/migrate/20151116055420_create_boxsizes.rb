class CreateBoxsizes < ActiveRecord::Migration
  def change
    create_table :boxsizes do |t|
      t.string :boxsize

      t.timestamps null: false
    end
  end
end
