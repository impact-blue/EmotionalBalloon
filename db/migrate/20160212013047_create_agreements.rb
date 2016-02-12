class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
