require 'rails_helper'

describe 'api/v1/read_sensor_data', type: :request do
  before do
    host! ENV['HOST_ADDRESS']
  end
  context 'unauthorized' do
    it 'returns 403' do
      get 'api/v1/read_sensor_data'

      expect(response.status).to eql(403)
    end
  end
  context 'authorized' do
    let(:token) { ENV['SENSORS_API_TOKEN'] }
    let(:headers) { { "ACCEPT": "application/json", "AUTHORIZATION": "Bearer #{token}" } }
    let(:params) { { "_id": "qwer" } }
    let!(:sensor) { Sensor.create(external_id:'qwer',
      name: 'qwer',
      device: 'test',
      location: 'qwer',
      location_max_capacity: 1234) }
    context 'sensor exists, but there is no sensor data ' do
      it 'returns 403' do
        get 'api/v1/read_sensor_data', params: params, headers: headers

        expect(response.status).to eql(404)
      end
    end
    context 'sensor exists, and returns data' do
      let!(:sensor_data) { SensorDatum.create(sensor_id: sensor.id,
        line1_total_in: 40,
        line1_total_out: 20,
        line1_period_in: 10,
        line1_period_out: 1234,
        location_occupancy_pct: 3.123) }
      it 'returns data' do
        get 'api/v1/read_sensor_data', params: params, headers: headers

        expect(JSON.parse(response.body).first).to include({
          "line1_total_in"=>40,
          "line1_total_out"=>20,
          "line1_period_in"=>10,
          "line1_period_out"=>1234,
          "location_occupancy_pct"=>3.123})
      end
    end
  end
end


