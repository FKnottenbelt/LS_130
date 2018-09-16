=begin
Write a unit test that will fail if list and the return value of
list.process are different objects.
=end

require 'minitest/autorun'

class List
  def process
    nil # self
  end
end

class MyTest < MiniTest::Test
  def test_returns_list_object
    @list = List.new
    assert_same(@list, @list.process)
  end
end