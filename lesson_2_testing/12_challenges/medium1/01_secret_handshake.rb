=begin

Secret Handshake

Write a program that will take a decimal number, and convert it to
the appropriate sequence of events for a secret handshake.

There are 10 types of people in the world: Those who understand
binary, and those who don't. You and your fellow cohort of those
in the "know" when it comes to binary decide to come up with a
secret "handshake".

1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.

handshake = SecretHandshake.new 9
handshake.commands # => ["wink","jump"]

handshake = SecretHandshake.new "11001"
handshake.commands # => ["jump","wink"]

The program should consider strings specifying an invalid binary
as the value 0.
=end


=begin
convert decimal num to binary(string):
divide by 2 move remainder to string
do same with result etc
reverse string

handshake:
convert binary to commands
1 = wink
10 = double blink
100 = close your eyes
1000 = jump
10000 = Reverse the order of the operations in the secret handshake.


1001 => ["wink","jump"] for 1 is  wink and 1000 is jump

=end
require 'pry'

class SecretHandshake
  attr_reader :winks
  COMMANDS = { 'jump' => 1000,
               'close your eyes' => 100,
               'double blink' => 10,
               'wink' => 1 }

  def initialize(winks)
    @winks = winks
  end

  def commands
    commands = []
    p number = to_binary(winks)
    int = number.to_i

    output = ''
    COMMANDS.each do |k, v|
      division = int / v
      binding.pry
      output <<  k * division
      int = int - (v * division) if division > 0
    end
  p  output
    # command = case number
    #           when '1' then 'wink'
    #           when '10' then 'double blink'
    #           when '100' then 'close your eyes'
    #           when '1000' then 'jump'
    #           else 'nnb'
    #           end
    commands << command
  end

  def to_binary(decimal)
    binary_num = ''

    loop do
      break if decimal < 1
      decimal, remainder = decimal.divmod(2)
      binary_num << remainder.to_s
    end

    binary_num.chars.reverse.join
  end

end


s = SecretHandshake.new(11)
# p s.to_binary(156) # 10011100
# p s.to_binary(9) # "1001"
# p s.to_binary(11001) #"10101011111001"
#p s.to_binary(1) # '1'
 s.to_binary(11) #=> 1101
#p s.to_binary(10011)  # "10011100011011"
p s.commands