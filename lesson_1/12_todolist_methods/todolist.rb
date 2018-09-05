# continuing on LS version.
require 'pry'
# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

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

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end
  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def undone!
    @todos.each_index do |idx|
      mark_undone_at(idx)
    end
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each
    counter = 0
    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
    self
  end

  def select
    selected = TodoList.new(title)
    @todos.each do |todo|
      selected << todo if yield(todo)
    end
    selected
  end

  def find_by_title(todo_title)
    # returns the first Todo object that matches the argument
    select { |todo| todo.title == todo_title}.first
  end

  def all_done
    # returns new TodoList object containing only the done items
    select { |todo| todo.done? }
  end

  def all_not_done
    # returns new TodoList object containing only the not done items
    select { |todo| !todo.done? }
  end

  def mark_done(todo_title)
    # takes a string as argument, and marks the first Todo object that
    # matches the argument as done.
    to_mark = find_by_title(todo_title)
    to_mark.done!
  end

  def mark_all_done
    # mark every todo as done
    each do |todo|
      todo.done!
    end
  end

  def mark_all_undone
    # mark every todo as not done
    each do |todo|
      todo.undone!
    end
  end

  def to_a
    @todos
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

puts "-- setup"
original =
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

# puts
# p original

puts
puts "--- find:"
p list.find_by_title("Clean room")
p list.find_by_title("Does not exist")

puts
puts "--- all not done"
p list.all_not_done

puts
puts "---setup"
todo2.done!
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

puts
puts "--- return all done"
p list.all_done

puts
puts "--set up"
list.mark_undone_at(0)
list.mark_undone_at(1)
list.mark_undone_at(2)
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

puts
puts "-- mark done (title)"
p list.mark_done("Go to gym")
puts
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

puts
puts "--set up"
list.mark_undone_at(0)
list.mark_undone_at(1)
list.mark_undone_at(2)
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

puts
puts "-- mark all done"
p list.mark_all_done
puts
list.each do |todo|
  puts todo                   # calls Todo#to_s
end

puts
puts "-- mark all undone"
p list.mark_all_undone
puts
list.each do |todo|
  puts todo                   # calls Todo#to_s
end