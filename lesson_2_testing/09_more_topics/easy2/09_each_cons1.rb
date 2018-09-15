=begin

each_cons (Part 1)

The Enumberable#each_cons method iterates over the members of a
collection taking each sequence of n consecutive elements at a
time and passing them to the associated block for processing.
It then returns a value of nil.

Write a method called each_cons that behaves similarly for
Arrays, taking the elements 2 at a time. The method should take
an Array as an argument, and a block. It should yield each
consecutive pair of elements to the block, and return nil.

Your method may use #each, #each_with_object, #each_with_index,
#inject, loop, for, while, or until to iterate through the Array
passed in as an argument, but must not use any other methods that
iterate through an Array or any other collection.

Examples:

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end

p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}

hash = {}
each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}

=end



def each_cons(array, n = 2)
  return [] if array.empty?
  pointer = 0
  loop do
    break if pointer == (array.size - (n-1))
    yield(array[pointer...(pointer + n)])
    pointer += 1
  end
  nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end

p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}

hash = {}
each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}

# ls solution
def each_cons(array)
  array.each_with_index do |item, index|
    break if index + 1 >= array.size
    yield(item, array[index + 1])
  end
end

=begin
Discussion

The hardest part of this exercise is trying to decide when to stop iterating. Obviously, we can't simply iterate over the entire Array, since there are no elements with which to pair the last element if we did. Instead, we need to stop when the current element is the last element, which we can detect by comparing the index + 1 against the Array size.
=end
