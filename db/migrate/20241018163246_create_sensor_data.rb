class CreateSensorData < ActiveRecord::Migration[7.2]
  def change
    create_table :sensor_data do |t|
      t.belongs_to :sensor
      t.integer :line1_total_in
      t.integer :line1_total_out
      t.integer :line1_period_in
      t.integer :line1_period_out
      t.float :location_occupancy_pct
      t.datetime :reported_at


      t.timestamps
    end
  end
end
