=begin

Sum of Multiples

Write a program that, given a number, can find the sum of all the
multiples of particular numbers up to but not including that number.

If we list all the natural numbers up to but not including 20 that
are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and
18. The sum of these multiples is 78.

Write a program that can find the sum of the multiples of a given
set of numbers. If no set of numbers is given, default to 3 and 5.
=end

=begin
i: number
P: find all multiples of set upto n (excluding n) and sum those
a: for each number in set
     loop from number +1 to n
       see if current num mod number equals 0
         if so then save
   sum saved numbers
=end
require 'pry'

class SumOfMultiples
  attr_reader :set

  def initialize(*set)
    @set = set == [] ? [3,5] : set
  end

  def self.to(n, set = [3,5])
    multiples = []
    set.each do |setnumber|
      multiples << find_multiples(setnumber, n)
    end
    multiples.flatten.uniq.sum
  end

  def to(n)
    self.class.to(n, set)
  end

  def self.find_multiples(setnumber, n)
    multiples = []
    ((setnumber)...n).each do |num|
      multiples << num if num % setnumber == 0
    end
    multiples
  end
end

#s1 = SumOfMultiples.new(7, 13, 17)
#p s1.set
#s2 = SumOfMultiples.new
#p s2.set
# p s2.to(10) #== 23
# p s1.to(20) #== 51
# p SumOfMultiples.to(10)
# p SumOfMultiples.new(7, 13, 17).to(20)
# p SumOfMultiples.to(100) #2_318


# top solutions
class SumOfMultiples
  def self.to(limit, multiples = [3, 5])
    (0...limit).select do |number|
      multiples.any? { |multiple| number % multiple == 0 }
    end.reduce(:+)
  end

  def initialize(*multiples)
    @multiples = multiples
  end

  def to(limit)
    self.class.to(limit, @multiples)
  end
end

#!/usr/bin/env ruby
# Copyright (c) 2016 Pete Hanson
# frozen_string_literal: true

class SumOfMultiples
  def initialize *multiples
    @multiples = multiples.empty? ? [3, 5] : multiples
  end

  def self.to up_to
    SumOfMultiples.new.to up_to
  end

  def to up_to
    (1...up_to).select { |number| multiple? number }
               .inject(0) { |sum, number| sum + number }
  end

  private

  def multiple? number
    @multiples.any? { |multiple| number % multiple == 0 }
  end
end

class SumOfMultiples
  attr_reader :multiples_of

  def self.to(max)
    SumOfMultiples.new(3, 5).to(max)
  end

  def initialize(*multiples_of)
    @multiples_of = multiples_of
  end

  def to(max)
    multiples_sum = 0
    (1...max).each { |num| multiples_sum += num if multiple?(num, multiples_of) }
    multiples_sum
  end

  private

  def multiple?(num, multiples_of)
    multiples_of.any? { |multiple| num % multiple == 0 }
  end
end
