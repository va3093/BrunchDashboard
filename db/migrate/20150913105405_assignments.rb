class Assignments < ActiveRecord::Migration
   def up
    drop_table :assignments
  end

  def down
    create_table :tablename do |t|
      t.string :user_id
      t.string :assignment_id
      

      t.timestamps        
    end
    add_index :tablenames, :anothertable_id
  end
end
