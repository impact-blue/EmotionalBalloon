class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.binary :image, limit: 10.megabyte
      t.string :image_content_type

      t.timestamps null: false
    end
  end
end