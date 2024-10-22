class CreateSensors < ActiveRecord::Migration[7.2]
  def change
    create_table :sensors do |t|
      t.string :external_id
      t.string :name
      t.string :location
      t.string :device
      t.integer :location_max_capacity

      t.timestamps
    end
  end
end
