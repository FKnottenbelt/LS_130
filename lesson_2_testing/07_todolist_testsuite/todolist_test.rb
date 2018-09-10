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

  def test_mark_done_at
    assert_raises(IndexError){ @list.mark_done_at(300) }
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError){ @list.mark_undone_at(300) }
    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at(1)

    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(300) }
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal(2, @list.size)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_to_s
    # using a HEREDOC
    # or: output = <<-OUTPUT.chomp.gsub /^\s+/, "" etc
    # to remove preceding spaces
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_one_done
    @todo1.done!
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    @list.done!
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each_iterates
    items = []
    @list.each { |todo| items << todo }

    assert_equal(@list.to_a, items)
  end

  def test_each_returns_original_list
    original = @list
    result = original.each { |todo| nil }

    assert_equal(@list, result)
  end
end
