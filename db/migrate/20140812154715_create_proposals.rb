class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :theme, index: true
      t.references :user, index: true
      t.string :title
      t.text :content
      t.integer :up, default: 0
      t.integer :down, default: 0

      t.timestamps
    end
  end
end
