=begin

Octal

Implement octal to decimal conversion. Given an octal input string,
your program should produce a decimal output.

Note:

Implement the conversion yourself. Do not use something else to
perform the conversion for you. Treat invalid input as octal 0.

About Octal (Base-8):

Decimal is a base-10 system.

A number 233 in base 10 notation can be understood as a linear
combination of powers of 10:

    The rightmost digit gets multiplied by 100 = 1
    The next number gets multiplied by 101 = 10
    ...
    The n*th number gets multiplied by 10n-1*.
    All these values are summed.

So:

  233 # decimal
= 2*10^2 + 3*10^1 + 3*10^0
= 2*100  + 3*10   + 3*1

Octal is similar, but uses powers of 8 rather than powers of 10.
So:

  233 # octal
= 2*8^2 + 3*8^1 + 3*8^0
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155
=end

class Octal
  attr_reader :octal

  def initialize(octal)
    @octal = octal.to_i
  end

  def to_decimal
    octal.digits.map.with_index do |num, ind|
      return 0 unless num.between?(0,7)
      num * (8 ** ind)
    end.sum
  end
end

#p Octal.new('6789').to_decimal # 0

#NB:  if it's an octal constant, then the only valid digits are 0 though 7

# top solutions
class Octal
  BASE = 8
  INVALID_OCTAL = /\D|[8-9]/

  attr_reader :octal_string

  def initialize(octal_string)
    @octal_string = octal_string
  end

  def to_decimal
    octal_string =~ INVALID_OCTAL ? 0 : calculate
  end

  private

  def calculate
    decimal = 0
    octal_string.reverse.each_char.with_index do |char, index|
      decimal += char.to_i * (BASE ** index)
    end
    decimal
  end

end

class Octal
  attr_reader :octal
  EXCEPTIONS = 'az89'
  BASE = 8

  def initialize(string)
    if string.downcase.count(EXCEPTIONS) > 0
      @octal = [0]
    else
      @octal = string.chars.reverse!.map(&:to_i)
    end
  end

  def to_decimal
    dec_array = []
    octal.each_index do |digit|
      dec_array << octal[digit] * BASE**digit
    end
    dec_array.reduce(:+)
  end
end

class Octal
  def initialize(str)
    @digits = str.chars
  end

  def to_decimal
    return 0 if @digits.any? { |digit| digit =~ /[^0-7]/ }
    @digits
      .map(&:to_i)
      .reverse
      .each_with_index
      .map { |digit, index| digit * (8 ** index) }
      .inject(:+)
  end
end
