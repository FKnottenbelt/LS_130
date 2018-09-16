=begin
Empty Object Assertions

Write a minitest assertion that will fail if the Array list is not empty.

=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_empty
    array = [1, 3, 5]
    assert_empty(array)
  end
end
