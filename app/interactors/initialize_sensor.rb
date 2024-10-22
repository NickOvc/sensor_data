class InitializeSensor
  include Interactor

  def call
    sensor = Sensor.find_or_create_by(external_id: context.external_id)
    sensor.update!(context.sensor_attributes)
    context.sensor = sensor
  rescue ActiveRecord::RecordInvalid => e
    context.error = e
    context.fail!
  rescue StandardError => e
    context.fail!(error: context.error)
  end
end