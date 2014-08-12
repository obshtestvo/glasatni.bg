class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.references :user, index: true
      t.references :votable, index: true, polymorphic: true
      t.integer :value

      t.timestamps
    end
  end
end
