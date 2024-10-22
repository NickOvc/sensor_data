require 'rails_helper'

describe Sensor do

  it { should validate_presence_of :name }
  it { should validate_presence_of :device }
  it { should validate_presence_of :location_max_capacity }
  it { should validate_presence_of :location }
end
