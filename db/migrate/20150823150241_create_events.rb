class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.string :status
      t.integer :number_of_volunteers

      t.timestamps null: false
    end
  end
end
