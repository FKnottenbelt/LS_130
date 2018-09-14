=begin

Count Items

Write a method that takes an array as an argument, and a block
that returns true or false depending on the value of the array
element passed to it. The method should return a count of the
number of times the block returns true.

You may not use Array#count or Enumerable#count in your solution.

Examples:

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2
=end

def count(array)
  count = 0
  array.each do |element|
    count += 1 if yield(element)
  end
  count
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2

=begin
Further Exploration

Write a version of the count method that meets the conditions
of this exercise, but also does not use each, loop, while, or
until.

==
def count(array)
  array.reduce(0) { |sum, el| yield(el) ? sum + 1 : sum }
end
==
def count(collection)
 reason = []
 collection.length.times do |count|
   reason.push(yield(collection[count]))
 end
 p reason.select {|x| x == true}.length
end

=end