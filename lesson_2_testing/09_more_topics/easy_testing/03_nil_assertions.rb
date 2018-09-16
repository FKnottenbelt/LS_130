=begin
Write a minitest assertion that will fail if value is not nil.
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_not_nil
    value = 'a'
    assert_nil(value)
  end
end