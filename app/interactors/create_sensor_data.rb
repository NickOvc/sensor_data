class CreateSensorData
  include Interactor

  def call
    context[:raw_sensor_data_attributes].deep_transform_keys!(&:underscore)
    location_occupancy_pct = calculate_location_occupancy_pct(context[:raw_sensor_data_attributes], context[:sensor][:location_max_capacity])
    reported_at = Time.current
    final_sensor_data_attributes = context[:raw_sensor_data_attributes].merge(location_occupancy_pct:, reported_at:)
    context.sensor_data = context.sensor.sensor_data.create!(final_sensor_data_attributes)
  rescue ActiveRecord::RecordInvalid => e
    context.error = e
    context.fail!
  rescue StandardError => e
    context.fail!(error: context.error)
  end

  private

  def calculate_location_occupancy_pct(data, max_capacity)
    max_capacity_number = max_capacity.to_i
    context.fail!(error: 'Location max capacity cannot be 0') if max_capacity_number.zero?

    one_hundred = 100
    occupancy_pct = (data[:line1_total_in].to_i - data[:line1_total_out].to_i) / (max_capacity_number * one_hundred).to_f
    occupancy_pct = 0 if occupancy_pct.negative?
    occupancy_pct
  end
end