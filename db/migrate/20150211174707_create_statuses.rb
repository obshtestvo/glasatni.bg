class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :proposal, index: true
      t.integer :kind
      t.text :notes

      t.timestamps
    end
  end
end
