require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup # will set up before every test (every one start 'clean')
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first) # [ ] Buy milk == [ ] Buy milk
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    first = @list.shift
    assert_equal(@todo1, first)
    assert_equal(2, @list.size )
    assert_equal([@todo2, @todo3], @list.to_a) # just in case
  end

end

