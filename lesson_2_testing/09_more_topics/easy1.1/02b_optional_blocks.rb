=begin
Further Exploration

Modify the compute method so it takes a single argument and yields
that argument to the block. Provide at least 3 examples of calling
this new version of compute, including a no-block call.
=end

def compute(arg)
  block_given? ? yield(arg) : "Does not compute."
end

p compute(5) { |num| num + 3 } == 8
p compute('a') { |string| string + 'b' } == 'ab'
p compute(4) == 'Does not compute.'
