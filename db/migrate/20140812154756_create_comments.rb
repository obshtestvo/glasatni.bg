class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :content
      t.integer :up
      t.integer :down

      t.timestamps
    end
  end
end
