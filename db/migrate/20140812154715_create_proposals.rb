class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :theme, index: true
      t.string :title
      t.text :content
      t.integer :up
      t.integer :down

      t.timestamps
    end
  end
end
