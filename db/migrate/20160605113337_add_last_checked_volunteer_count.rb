class AddLastCheckedVolunteerCount < ActiveRecord::Migration
  def change
  	    add_column :events, :last_checked_volunteer_count, :int
  end
end
