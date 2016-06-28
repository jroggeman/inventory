class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :room
      t.text :contents
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :boxes, :name
  end
end
