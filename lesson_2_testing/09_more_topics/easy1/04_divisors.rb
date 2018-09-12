=begin
Divisors

Write a method that returns a list of all of the divisors of
the positive integer passed in as an argument. The return value
can be in any sequence you wish.

Examples

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
=end

=begin
p: divide by all nums 1..n
   if mod 0 than add to output array
=end
def divisors(int)
  divisors = []
  (1..int).each do |num|
    divisors << num if int % num == 0
  end
  divisors
end
p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(99400891) == [1, 9967, 9973, 99400891]

# LS solution
def divisors(number)
  1.upto(number).select do |candidate|
    number % candidate == 0
  end
end


# how to make it go faster?

# "half of the divisors gives you the other half."