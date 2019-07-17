class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :table, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.timestamps
    end
  end
end
