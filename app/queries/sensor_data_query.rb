class SensorDataQuery
  def call(sensor, start_date = nil, end_date = nil)
    sensor.sensor_data.where(reported_at: start_date..end_date).order(reported_at: :desc)
  end
end
