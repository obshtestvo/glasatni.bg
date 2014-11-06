class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.text :info
      t.references :user
      t.integer :proposals_count, default: 0

      t.timestamps
    end
  end
end
