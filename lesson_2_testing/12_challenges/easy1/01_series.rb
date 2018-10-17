=begin

Series

Write a program that will take a string of digits and give you all
the possible consecutive number series of length n in that string.

For example, the string "01234" has the following 3-digit series:

- 012
- 123
- 234

And the following 4-digit series:

- 0123
- 1234

And if you ask for a 6-digit series from a 5-digit string, you
deserve whatever you get.
=end

class Series
  attr_reader :digits

  def initialize(digits)
    @digits = digits.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError if n > digits.size
    slices = []
    digits.each_cons(n) do |element|
      slices << element
    end
    slices
  end
end

# s = Series.new('01234')

# ls tip:
# each_cons(n).to_a

class Series
  attr_reader :digits

  def initialize(digits)
    @digits = digits.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError if n > digits.size
    digits.each_cons(n).to_a
  end
end
