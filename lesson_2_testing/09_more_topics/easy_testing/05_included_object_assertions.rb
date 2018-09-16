=begin
Included Object Assertions

Write a minitest assertion that will fail if the 'xyz' is not in
the Array list.

=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_is_xyz_included
    array = ['a', 'b']
    assert(array.include?('xyz'))  # or:
    assert_includes array, 'xyz' # nicer error message
  end
end

