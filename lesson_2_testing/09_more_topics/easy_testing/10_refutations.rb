=begin
Write a unit test that will fail if 'xyz' is one of the elements in
the Array list
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_xyz_is_not_in_array
    value = 'xyz'
    array = [1, 2, 'xyz']
    refute_includes(array, value)
  end
end