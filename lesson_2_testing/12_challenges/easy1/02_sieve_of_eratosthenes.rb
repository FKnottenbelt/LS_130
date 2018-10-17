=begin

Sieve of Eratosthenes

Write a program that uses the Sieve of Eratosthenes to find all the
primes from 2 up to a given number.

The Sieve of Eratosthenes is a simple, ancient algorithm for
finding all prime numbers up to any given limit. It does so by
iteratively marking as composite (i.e. not prime) the multiples of
each prime, starting with the multiples of 2.

Create your range, starting at two and continuing up to and including
the given limit. (i.e. [2, limit]).

The algorithm consists of repeating the following over and over:

    take the next available unmarked number in your list (it is prime)
    mark all the multiples of that number (they are not prime)

Repeat until you have processed each number in your range. When the
algorithm terminates, all the numbers in the list that have not been
marked are prime. The wikipedia article has a useful graphic that
explains the algorithm.
https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

Notice that this is a very specific algorithm, and the tests don't
check that you've implemented the algorithm, only that you've come
up with the correct list of primes.

=end

=begin
make range from 2 to to n
loop through range. for each num, 'mark' all multiples
   - loop through range and if element % num == 0 then mark
delete all marked
return rest

range [2,3,4,5,6,7,8,9,10]
pos prime = 2
 3 % 2 == 0 ? mark : skip
 4 % 2 == 0 ? mark : skip
 5 % 2 == 0 ? mark : skip
=end

class Sieve
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def primes
    prime_nums = (2..number).to_a
    counter = 2
    loop do
      break if counter > number
      prime_nums.map! do |number|
        if number % counter == 0 && number != counter
          'x'
        else
          number
        end
      end
      counter += 1
    end
    prime_nums.delete('x')
    prime_nums
  end
end

# top solutions
class Sieve
  attr_reader :range

  def initialize(last_num)
    @range = (2..last_num).to_a
  end

  def primes
    range.each do |prime|
      range.reject! { |num| (num != prime) && (num % prime == 0) }
    end
    range
  end

end

class Sieve
  attr_reader :numbers

  def initialize(limit)
    @numbers = [*(2..limit)]
  end

  def primes
    primes = []

    while (prime = numbers.delete_at(0))
      primes << prime
      numbers.delete_if { |number| number % prime == 0 }
    end

    primes
  end
end

class Sieve

  FIRST_PRIME = 2

  def initialize(limit)
    @limit = limit
  end

  def primes
    raise(ArgumentError) if @limit < FIRST_PRIME

    range = (FIRST_PRIME..@limit)
    primes = range.to_a

    range.each do |t|
      primes.reject! { |number| (number % t == 0) unless number == t }
    end

    primes
  end
end
