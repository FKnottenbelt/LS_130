=begin

Trinary

Write a program that will convert a trinary number, represented as
a string (e.g. '102012'), to its decimal equivalent using first
principles (without using an existing method or library that can work
with numeral systems).

Trinary numbers can only contain three symbols: 0, 1, and 2. Invalid
trinary entries should convert to decimal number 0.

The last place in a trinary number is the 1's place. The second to
last is the 3's place, the third to last is the 9's place, etc.

# "102012"
    1       0       2       0       1       2    # the number
1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0    # the value
  243 +     0 +    54 +     0 +     3 +     2 =  302


=end

class Trinary
  attr_reader :number
  VALID_TRINARY = /[012]/

  def initialize(string)
    @number = validated_string(string)
  end

  def validated_string(string)
    string =~ VALID_TRINARY ? string.to_i : 0
  end

  def to_decimal
    number.digits.map.with_index do |num, ind|
      num * (3 ** ind)
    end.sum
  end
end

# top solutions
class Trinary
  def initialize(str)
    @trinary = str
  end

  def to_decimal
    return 0 if invalid_trinary?
    numbers = @trinary.reverse.chars.map(&:to_i)
    numbers.each_with_index.map { |num, idx| 3**idx * num }.inject(:+)
  end

  private

  def invalid_trinary?
    @trinary.match(/[^0-2]/)
  end
end

class Trinary
  def initialize(input)
    @value = /^[0-2]+$/ =~ input ? input : '0'
  end

  def to_decimal
    @value.chars.inject(0) { |sum, num| (sum + num.to_i) * 3 } / 3
  end
end