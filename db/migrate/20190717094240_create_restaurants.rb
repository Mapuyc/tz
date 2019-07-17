class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, index: { unique: true }
      t.jsonb :working_days, default: []
      t.time :opens
      t.time :closes
      t.timestamps
    end
  end
end
