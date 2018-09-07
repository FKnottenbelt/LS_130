# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
require 'pry'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.
require 'forwardable'

class TodoList
  extend Forwardable
  attr_accessor :title
  attr_reader :todos

  def_delegators :@todos, :size, :first, :last, :shift, :pop,
    :each

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(to_do)
    todos << to_do if to_do.class == Todo
    raise TypeError, "Can only add Todo objects" if to_do.class != Todo

    rescue TypeError => e
      puts e.message + ". #{to_do} is not a Todo object"
  end

  def item_at(index)
    raise IndexError if index >= todos.size || index < 0
    todos[index]

    rescue IndexError => e
      puts "#{e.class}: Sorry, I don't have an item at #{index} in my list"
  end

  def mark_done_at(todos_index)
    raise IndexError if todos_index >= todos.size || todos_index < 0
    todos[todos_index].done!

    rescue IndexError => e
      puts "#{e.class}: Sorry, I don't have an item at #{todos_index} in my list"
  end

  def mark_undone_at(todos_index)
    raise IndexError if todos_index >= todos.size || todos_index < 0
    todos[todos_index].undone!

    rescue IndexError => e
      puts "#{e.class}: Sorry, I don't have an item at #{todos_index} in my list"
  end

  def remove_at(todos_index)
    raise IndexError if todos_index >= todos.size || todos_index < 0
    todos.delete_at(todos[todos_index])

    rescue IndexError => e
      puts "#{e.class}: Sorry, I don't have an item at #{todos_index} in my list"
  end

  def to_s
    string = "---- #{title} ----\n"
    todos.each do |todo|
      string << todo.to_s
      string << "\n"
    end
    string

  end

  alias_method :<<, :add
  private

  attr_writer :todos
end

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end