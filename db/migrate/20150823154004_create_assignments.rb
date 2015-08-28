class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :assignment, index: true

      t.timestamps null: false
    end
  end
end
