=begin
Write a minitest assertion that will fail if value is not an instance
of the Numeric class exactly. value may not be an instance of one of
Numeric's superclasses.
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_not_instance_of_numeric_class
    value = 'Hello'
    assert_instance_of(Numeric, value)
  end
end