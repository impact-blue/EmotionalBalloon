class CreateBalloonTypes < ActiveRecord::Migration
  def change
    create_table :balloon_types do |t|
      t.string :balloon_type

      t.timestamps null: false
    end
  end
end
