class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :info

      t.timestamps
    end
  end
end
