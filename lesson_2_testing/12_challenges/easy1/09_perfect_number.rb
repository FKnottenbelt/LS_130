=begin

Perfect Number

The Greek mathematician Nicomachus devised a classification scheme for
natural numbers, identifying each as belonging uniquely to the categories
of abundant, perfect, or deficient. A perfect number equals the sum of its
positive divisors — the pairs of numbers whose product yields the target
number, excluding the number itself. This sum is known as the Aliquot sum.

    Perfect: Sum of factors = number
    Abundant: Sum of factors > number
    Deficient: Sum of factors < number

Examples:

    6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 + 3.
    28 is a perfect number because 28 = 1 + 2 + 4 + 7 + 14.
    Prime numbers 7, 13, etc are deficient by the Nicomachus classification.

Write a program that can tell if a number is perfect, abundant or deficient.
=end

=begin
i: integer
o: string : abundant, perfect, or deficient
a: input number should be positive
   find divisors of num
     for 1 to num (not including num):
     if num mod x equals 0 it is a divisor
     save all divisors
   add divisors
   check rule to determine sort
   output sort
=end

class PerfectNumber
  def self.classify(number)
    raise RuntimeError if number <= 0

    sum = get_divisors(number).sum
    if sum == number
      'perfect'
    elsif sum > number
      'abundant'
    else
      'deficient'
    end
  end

  def self.get_divisors(number)
    divisors = []
    (1...number).each do |num|
      divisors << num if number % num == 0
    end
    divisors
  end
end

# top solutions
class PerfectNumber
  def self.classify(number)
    raise RuntimeError if number < 0

    factors = (1...number).select { |num| number % num == 0 }

    result = factors.reduce(:+)

    case
      when result < number then 'deficient'
      when result > number then 'abundant'
      when result == number then 'perfect'
    end
  end
end

class PerfectNumber
  def self.classify(number)
    fail 'Number must be greater than 0' if number <= 0

    sum_of_factors = (1...number).select { |num| number % num == 0 }.reduce(:+)

    if sum_of_factors > number
      'abundant'
    elsif sum_of_factors == number
      'perfect'
    else
      'deficient'
    end
  end
end

class PerfectNumber
  def self.sum_of_factors(number)
    sum = 1
    (2..number / 2).to_a.each do |num|
      sum += num if number % num == 0
    end
    sum
  end

  def self.classify(number)
    raise RuntimeError if number <= 0

    factors = sum_of_factors(number)
    case
    when factors < number
      'deficient'
    when factors == number
      'perfect'
    when factors > number
      'abundant'
    end
  end
end
