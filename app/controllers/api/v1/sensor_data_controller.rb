class Api::V1::SensorDataController < ApplicationController
  before_action :validate_create_params, only:[:create_sensor_data]
  before_action :validate_read_params, only:[:read_sensor_data]
  SENSOR_KEY_LIST = %w(name location device location_max_capacity)
  SENSOR_DATA_KEY_LIST = %w(line1TotalIn line1TotalOut line1PeriodIn line1PeriodOut)

  def create_sensor_data
    service = SensorDataManager.call(external_id: params[:_id],
      sensor_attributes: filtered_sensor_attributes,
      raw_sensor_data_attributes: filtered_sensor_data_attributes
    )
    if service.success?
      render json: { message: 'Ok' }, status: 201
    else
      render_error(service.error, 422 )
    end
  end

  def read_sensor_data
    return render_error('Sensor not found', 404) unless find_sensor

    sensor_data = ::SensorDataQuery.new.call(@sensor, params[:start_date], params[:end_date])
    if sensor_data.empty?
      render_error('Sensor data not found', 404)
    else
      render json: sensor_data
    end
  end

  private

  def validate_create_params
    param! :contextMap, Hash, required: true
    param! :contextMap, Hash do |b|
      b.param! :name, String, required: true
      b.param! :location, String, required: true
      b.param! :device, String, required: true
      b.param! :location_max_capacity, String, required: true
    end
  rescue RailsParam::InvalidParameterError => e
    render_error(e.message, 422 )
  end

  def validate_read_params
    param! :_id, String, required: true
    param! :start_date, DateTime, required: false
    param! :end_date, DateTime, required: false
  rescue RailsParam::InvalidParameterError => e
    render_error(e.message, 422 )
  end

  def filtered_sensor_attributes
    params[:contextMap].select { |key| SENSOR_KEY_LIST.include?(key) }.permit!
  end

  def filtered_sensor_data_attributes
    params.select { |key| SENSOR_DATA_KEY_LIST.include?(key) }.permit!
  end

  def find_sensor
    @sensor = Sensor.find_by(external_id: params['_id'])
  end
end