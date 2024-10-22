require 'rails_helper'

describe 'api/v1/create_sensor_data', type: :request do
  before do
    host! ENV['HOST_ADDRESS']
  end

  let(:params) { { "name": "testname",
    "line1TotalIn": 14698,
    "line1TotalOut": 13062,
    "line1PeriodIn": 0,
    "line1PeriodOut": 3,
    "_id": "some string id",
    "contextMap": {
      "name": "testname",
      "location": "testLocation",
      "device": "testdevice",
      "location_max_capacity": "100" } } }

  context 'unauthorized' do
    it 'returns 403' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post 'api/v1/create_sensor_data', params: params, headers: headers

      expect(response.status).to eql(403)
    end
  end

  context 'authorized' do
    let(:token) { ENV['SENSORS_API_TOKEN'] }
    let(:headers) { { "ACCEPT": "application/json", "AUTHORIZATION": "Bearer #{token}" } }
    it 'returns 403' do
      post 'api/v1/create_sensor_data', params: params, headers: headers

      expect(response.status).to eql(201)
    end

    context 'wrong params' do
      it 'returns error' do
        post 'api/v1/create_sensor_data', params: params.delete(:contextMap), headers: headers

        expect(JSON.parse(response.body)['error']['message']).to eql("Parameter contextMap is required")
      end
    end
  end
end


