# Methods with an explicit block parameter

def test(&block)
  puts "What's &block? #{block}"
end

test { sleep(1) }

# What's &block? #<Proc:0x000000017a7ca8@example_08.rb:7>
# => nil

puts
puts

def test2(block)
  puts "What's &block? #{block}" #<Proc:0x00000001b7b2a8@example_08.rb:27>
  puts "hello"
  block.call         # xyz
  puts "good-bye"
end

def test1(&block)
  puts "What's &block? #{block}" #<Proc:0x00000001b7b2a8@example_08.rb:27>
  puts '1'
  test2(block)
  puts '2'
end

test1 { puts "xyz" }

# What's &block? #<Proc:0x000000020668a8@example_08.rb:29>
# 1
# What's &block? #<Proc:0x000000020668a8@example_08.rb:29>
# hello
# xyz
# good-bye
# 2

