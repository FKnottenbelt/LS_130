# the original:
# array = [1, 2, 3, 4, 5]

# array.select { |num| num.odd? }       # => [1, 3, 5]
# array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

=begin
Note that the Array#select method takes a block, then
yields each element to the block. If the block evaluates
to true, the current element will be included in the
returned array. If the block evaluates to false, the
current element will not be included in the returned
array.
=end

def select(array)
  counter = 0
  selected = []
  while counter < array.size
    result = yield(array[counter])
    selected << array[counter] if result
    counter += 1
  end
  selected
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true


# ls solution
def select(array)
  counter = 0
  result = []

  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element)
    counter += 1
  end

  result
end
