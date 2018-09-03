# original:
# [1, 2, 3].reduce do |acc, num|
#   acc + num
# end

# => 6

# The reduce method iterates through the array, and unlike each where it only
# yields 1 argument to the block, the reduce method yields two arguments to the
# block. The first argument is an accumulator object, and the second argument
# is the current element. The return value of the block is then assigned to the
# accumulator object.
# You can initialize the accumulator to a default value

# [1, 2, 3].reduce(10) do |acc, num|
#   acc + num
# end

# => 16

def reduce(array, acc = 0)
  counter = 0
  while counter < array.size
    acc = yield(acc, array[counter])
    counter += 1
  end
  acc
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass


# LS
def reduce(array, default=0)
  counter = 0
  accumulator = default

  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end

  accumulator
end

# Note that we used a while loop here, but since we are expecting
# an Array object as the parameter, we could have as well used
# the Array#each to iterate.