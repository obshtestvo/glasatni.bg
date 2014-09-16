class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :user, index: true
      t.references :flaggable, index: true, polymorphic: true
      t.integer :reason

      t.timestamps
    end
  end
end
