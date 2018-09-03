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

  def_delegators :@todos, :size, :first, :last, :shift, :pop

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

=begin
- our collection of Todo objects should have a title, or perhaps a due date.
- We could also append two TodoList objects together to get a new TodoList
- our TodoList should only work with Todo objects
=end

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

puts
p "---- Adding to the list ----- : done."
# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
#list.add(todo3)                 # adds todo3 to end of list, returns list
list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add
list << todo3

puts
p "---- Interrogating the list ----- : done."

# size
p list.size                       # returns 3

# first
p list.first                      # returns todo1, which is the first item in the list

# last
p list.last                       # returns todo3, which is the last item in the list

puts
p "---- Retrieving an item in the list ---- : done."

# item_at
#list.item_at                    # raises ArgumentError
p list.item_at(1)                 # returns 2nd item in list (zero based index)
p list.item_at(100)               # raises IndexError
p list.item_at(-2)               # raises IndexError

puts
p "---- Marking items in the list ----- : done."

# mark_done_at
#list.mark_done_at               # raises ArgumentError
list.mark_done_at(1)            # marks the 2nd item as done
list.mark_done_at(100)          # raises IndexError

# mark_undone_at
#list.mark_undone_at             # raises ArgumentError
list.mark_undone_at(1)          # marks the 2nd item as not done,
list.mark_undone_at(100)        # raises IndexError

puts
p "---- Deleting from the the list ----- : done."
#p list.todos

# shift
#p list.shift                      # removes and returns the first item in list

# pop
#p list.pop                        # removes and returns the last item in list

# remove_at
#list.remove_at                  # raises ArgumentError
#list.remove_at(1)               # removes and returns the 2nd item
#list.remove_at(100)             # raises IndexError

puts
p "---- Outputting the list ----- : done."
p list.todos
# to_s
puts list.to_s                      # returns string representation of the list
list.mark_done_at(1)
puts list.to_s
# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

# or, if any todos are done

# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym