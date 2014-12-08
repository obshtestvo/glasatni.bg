class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :proposal
      t.integer :action
      t.references :recipient
      t.references :user
      t.boolean :seen, null: false, default: false
    end
  end
end

