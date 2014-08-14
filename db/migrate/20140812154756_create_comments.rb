class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :proposal
      t.references :user, index: true
      t.text :content
      t.integer :up, default: 0
      t.integer :down, default: 0

      t.timestamps
    end
  end
end
