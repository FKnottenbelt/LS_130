=begin
Write a minitest assertion that will fail if the class of value is not
Numeric or one of Numeric's subclasses (e.g., Integer, Fixnum, Float, etc).
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_is_of_numeric_class
    value = 3.5 # "hello"
    assert_kind_of(Numeric, value)
  end
end