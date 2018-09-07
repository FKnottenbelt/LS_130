# Return value of yielding to the block

puts "example 1:"

def compare(str)
  puts "Before: #{str}"
  puts "After: #{yield str}"
end

compare('hi') { |word| word.upcase }

# Output:
# Before: hi
# After: HI

puts
puts "example 2:"
compare('hello') { |word| word.slice(1..2) }
# Before: hello
# After: el
# => nil

puts
puts "example 3:"

compare('hello') { |word| "nothing to do with anything" }

puts
puts "example 4:"

compare('hello') { |word| puts "hi" }
# Before: hello
# hi
# After:
# => nil

# LS:
puts
puts "example 1 again:"

def compare(str)
  puts "Before: #{str}"
  after = yield(str)   # assign return value of block
  puts "After: #{after}"
end

# method invocation
compare('hi') { |word| word.upcase }

