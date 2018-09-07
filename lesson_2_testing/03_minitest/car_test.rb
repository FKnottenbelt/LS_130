require 'minitest/autorun'

require_relative 'car'  # <== file to test

class CarTest < Minitest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end