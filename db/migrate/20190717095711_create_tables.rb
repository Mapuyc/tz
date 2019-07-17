class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.belongs_to :restaurant, index: true, foreign_key: true
      t.integer :number
      t.timestamps
    end
  end
end
