=begin
The Luhn formula is a simple checksum formula used to validate a variety
of identification numbers, such as credit card numbers and Canadian Social
Insurance Numbers.

The formula verifies a number against its included check digit, which is
usually appended to a partial number to generate the full number. This
number must pass the following test:

    Counting from rightmost digit (which is the check digit) and moving
    left, double the value of every second digit.
    For any digits that thus become 10 or more, subtract 9 from the result.
        1111 becomes 2121.
        8763 becomes 7733 (from 2x6=12 -> 12-9=3 and 2x8=16 -> 16-9=7).
    Add all these digits together.
        1111 becomes 2121 sums as 2+1+2+1 to give a checksum of 6.
        8763 becomes 7733, and 7+7+3+3 is 20.

If the total (the checksum) ends in 0 (put another way, if the total
modulus 10 is congruent to 0), then the number is valid according to
the Luhn formula; else it is not valid. So, 1111 is not valid (as shown
above, it comes out to 6), while 8763 is valid (as shown above, it comes
out to 20).

Write a program that, given a number

    Can check if it is valid per the Luhn formula. This should treat, for
    example, "2323 2005 7766 3554" as valid.

    Can return the checksum, or the remainder from using the Luhn method.

    Can add a check digit to make the number valid per the Luhn formula
    and return the original number plus that digit. This should give
    "2323 2005 7766 3554" in response to "2323 2005 7766 355".

About Checksums:

A checksum has to do with error-detection. There are a number of different
ways in which a checksum could be calculated.

When transmitting data, you might also send along a checksum that says
how many bytes of data are being sent. That means that when the data
arrives on the other side, you can count the bytes and compare it to
the checksum. If these are different, then the data has been garbled
in transmission.

In the Luhn problem the final digit acts as a sanity check for all
the prior digits. Running those prior digits through a particular
algorithm should give you that final digit.

It doesn't actually tell you if it's a real credit card number, only
that it's a plausible one. It's the same thing with the bytes that get
transmitted -- you could have the right number of bytes and still have
a garbled message. So checksums are a simple sanity-check, not a real
in-depth verification of the authenticity of some data. It's often a
cheap first pass, and can be used to quickly discard obviously invalid
things.
=end

=begin
check if valid:
- input: integer when Luhn made
- output: boolean

get the checksum.
if the checksum ends in a 0 the number integer was a valid Luhn
  - sum % 10 == 0
return boolean

checksum
- input: integer when Luhn made
- output: checksum
split the integer into digits and reverse
for all the odd indexes , double the number.
   if the number > 10 do minus 9
sum all your numbers. This is the checksum

create
- make int into digits (revered)
- add 0 to beginning
- get the checksum for the digits
- new digit = 10 - last digit of checksum (or last if allready 0)
- replace our first 0 with the new digit

addends
this are the digits in the checksum before we sum them
=end

class Luhn
  attr_reader :number

  def initialize(num)
    @number = num.digits
  end

  def addends
    self.class.calculate_checksum_digits(number)
  end

  def checksum
    self.class.calculate_checksum_digits(number).sum
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(num)
    # makes the number valid by adding a digit
    digits = num.digits
    digits.unshift(0)
    checksum = calculate_checksum_digits(digits).sum

    _, last = checksum.divmod(10)
    last != 0 ? (last = 10 - last) : last

    digits[0] = last
    digits.reverse.join.to_i
  end

  def self.calculate_checksum_digits(digits)
    digits.map.with_index do |num, ind|
      if ind.odd?
        new_num = num * 2
        new_num -= 9 if new_num > 10
        num = new_num
      end
      num
    end.reverse
  end
end

# LS solution
class Luhn
  def initialize(number)
    @digits = number.to_s.split('').map(&:to_i)
  end

  def number
    @digits.map(&:to_s).join.to_i
  end

  def addends
    @digits.reverse.each_with_index.map do |digit, index|
      if index.even?
        digit
      else
        digit * 2 > 10 ? digit * 2 - 9 : digit * 2
      end
    end.reverse
  end

#   def checksum
#     addends.reduce(&:+)
#   end

#   def valid?
#     checksum % 10 == 0
#   end

#   def self.create(number)
#     new_base_number = number * 10
#     if new(new_base_number).valid?
#       new_base_number
#     else
#       luhn_remainder = new(new_base_number).checksum % 10
#       new_base_number + (10 - luhn_remainder)
#     end
#   end
# end
