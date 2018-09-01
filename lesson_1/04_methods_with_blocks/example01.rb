# In Ruby, every method can take an optional block as an implicit
# parameter.

def hello
  "hello"
end

hello  # irb: returns 'hello'

#hello('hi') # wrong number of arguments (given 1, expected 0)

hello { puts 'hi'}  # outputs nothing. In irb it returns 'hello'
#(no print)

p hello { puts 'hi'} # => 'hello'
# in irb
# "hello"
# => "hello"

