=begin

Zipper

The Array#zip method takes two arrays, and combines them into
a single array in which each element is a two-element array where
the first element is a value from one array, and the second element
is a value from the second array, in order. For example:

[1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

Write your own version of zip that does the same type of operation.
It should take two Arrays as arguments, and return a new Array
(the original Arrays should not be changed). Do not use the
built-in Array#zip method. You may assume that both input arrays
have the same number of elements.

Example:

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

=end

def zip(arr1, arr2)
  new_array = []
  counter = 0
  loop do
    break if counter == arr1.size
    new_array << [arr1[counter], arr2[counter]]
    counter += 1
  end
  new_array
end


p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

# ls solution (refactoring a loop like above)
def zipper(array1, array2)
  array1.each_with_index.with_object([]) do |(element, index), result|
    result << [element, array2[index]]
  end
end
