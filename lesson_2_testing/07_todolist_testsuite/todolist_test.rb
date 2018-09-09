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

  def test_pop
    last = @list.pop
    assert_equal(@todo3, last)
    assert_equal(2, @list.size)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    @todo1.done = true
    @todo3.done = true
    todos = @list.instance_variable_get("@todos")
    no_of_dones = todos.map(&:done).select{ |action| action == true }.count
    assert_equal(2, no_of_dones)
  end

  def test_done_question # ls version of test_done?
    assert_equal(false, @list.done?)
  end

  def test_typeerror_when_adding_non_todo_object
    assert_raises(TypeError) {@list.add(2)}
    assert_raises(TypeError) { @list.add('hi') }
  end

  def test_shovel_adds_todo_to_list
    todo4 = Todo.new("Test << method")
    @list << todo4
    todos = @list.instance_variable_get("@todos")
    assert_same(todo4, todos.last)
  end

  def test_shovel # ls version of <<
    new_todo = Todo.new("Walk the dog")
    @list << new_todo
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_add_alias
    new_todo = Todo.new("Test add alias for <<")
    @list.add(new_todo)
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError){ @list.item_at(300) }
    assert_same(@todo1, @list.first)
  end
end


