class CreateMailContents < ActiveRecord::Migration
  def change
    create_table :mail_contents do |t|
      t.string :subject
      t.text :text

      t.timestamps null: false
    end
  end
end
