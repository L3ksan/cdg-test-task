# frozen_string_literal: true
require 'rspec'
require './price_delivery'

private

incorrect_package = PriceDelivery.new(weight: 5, length: 0, width: 10, height: 10)
correct_package = PriceDelivery.new(weight: 5, length: 10, width: 10, height: 10)

example_distance = 100
test_light_small = PriceDelivery.new(weight: 5, length: 10, width: 10, height: 10, distance: example_distance)
test_light_huge = PriceDelivery.new(weight: 5, length: 100, width: 100, height: 200, distance: example_distance)
test_heavy_huge = PriceDelivery.new(weight: 15, length: 100, width: 200, height: 200, distance: example_distance)

RSpec.describe 'Class methods' do
  it 'Correct places, Russia' do
    origin = 'Russia, Moscow'
    destination = 'Russia, Ufa'
    expect(correct_package.get_distance(origin, destination).to_f).to be_within(20).of(1352.4)
  end

  it 'Correct places, USA' do
    origin = 'Seattle'
    destination = 'New York'
    # expect(test.get_distance(origin, destination)).by a_value_within(0.1).of(2.5) eq('4589.6 km')
    # expect(test.get_distance(origin, destination)).to include('km')
    expect(correct_package.get_distance(origin, destination).to_f).to be_within(50).of(4600.0)
  end

  it 'Incorrect places, USA and Russia' do
    origin = 'Seattle'
    destination = 'Russian, Moscow'
    expect(correct_package.get_distance(origin, destination)).to eq('ZERO_RESULTS')
  end

  it 'Incorrect sizes package' do
    expect(incorrect_package.calculate_price).to eq(-1)
  end

  it 'Light & Small package' do
    expect(test_light_small.calculate_price).to eq(example_distance * 1.0)
  end

  it 'Light & Huge package' do
    expect(test_light_huge.calculate_price).to eq(example_distance * 2.0)
  end

  it 'Heavy & Huge package' do
    expect(test_heavy_huge.calculate_price).to eq(example_distance * 3.0)
  end
end

# start command: rspec .\price_delivery_spec.rb  --format=doc