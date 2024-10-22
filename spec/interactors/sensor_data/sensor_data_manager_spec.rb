require "rails_helper"
describe SensorDataManager do
  let(:external_id) { 'some string id'}
  let!(:sensor_attributes) { ActionController::Parameters.new(name: "testname",
    location: "testLocation",
    device: "testdevice",
    location_max_capacity: "100").permit! }
  let!(:raw_sensor_data_attributes) { ActionController::Parameters.new(line1TotalIn: 14698,
    line1TotalOut: 13062,
    line1PeriodIn: 0,
    line1PeriodOut: 3).permit! }
  subject(:context) do
    SensorDataManager.call(external_id:, sensor_attributes:, raw_sensor_data_attributes:)
  end

  describe '.call' do
    it 'succeeds' do
      expect(context.success?).to be_truthy
    end
  end
end
