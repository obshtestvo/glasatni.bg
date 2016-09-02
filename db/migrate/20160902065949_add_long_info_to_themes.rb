class AddLongInfoToThemes < ActiveRecord::Migration
  def up
    add_column :themes, :long_info, :text

    Theme.all.each do |t|
    	t.long_info = t.info
    	t.save
    end
  end

  def down
  	remove_column :themes, :long_info
  end
end

