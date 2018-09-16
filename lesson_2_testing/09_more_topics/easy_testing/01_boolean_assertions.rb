=begin
Write a minitest assertion that will fail if the value.odd? is not true.
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_boolean
    value = 4
    assert(value.odd?, 'value not odd')
  end
end