class AddArchivedToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :archived, :boolean, default: false
  end
end
