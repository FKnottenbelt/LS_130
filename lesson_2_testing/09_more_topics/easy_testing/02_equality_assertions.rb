=begin
Write a minitest assertion that will fail if value.downcase does
not return 'xyz'.
=end

require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_downcase
    value = 'xYyz'
    assert_equal('xyz', value.downcase)
  end
end