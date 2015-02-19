class CreateStatuses < ActiveRecord::Migration
  def up
    create_table :statuses do |t|
      t.references :proposal, index: true
      t.integer :kind
      t.text :notes

      t.timestamps
    end

    Proposal.approved.each do |p|
      Status.create!(kind: 0, proposal: p)
    end
  end

  def down
    drop_table :statuses
  end
end
