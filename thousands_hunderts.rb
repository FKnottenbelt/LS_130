###
# get all the (number of) thousands, hunderts etc
#
class Integer
  NUMERALS = { 'M' => 1000, 'CM' => 900, 'D' => 500, 'CD' => 400,
               'C' => 100, 'XC' => 90, 'L' => 50, 'XL' => 40,
               'X' => 10, 'IX' => 9, 'V' => 5, 'IV' => 4, 'I' => 1 }

  def to_roman
    int = self
    output = ''
    NUMERALS.each do |roman, number|
      division = int / number
      output <<  roman * division
      int -= (number * division) if division > 0
    end
    output
  end
end

# p 1024.to_roman # 'MXXIV'
division = 1024 / 1000 = 1
M * 1 = M
output = 'M'
int = 1024 - (1000 * 1) = 24

divsion = 24 / 900 = 0
CM * 0 = ""
output = 'M'

division 24 / 500 = 0
division 24 / 400 = 0
division 24 / 100 = 0
division 24 / 90 = 0
[...]
division 24 / 10 = 2
X * 2 = XX
output = 'MXX'
int = 24 - (10 * 2) = 4

division = 4 / 9 = 0
[..]
division = 4 / 4 = 1
IV * 1 = IV
output = 'MXXIV'
int = 4 - (4 * 1) = 0

division = 0 / 1 = 0

=> output is 'MXXIV'

####
# get all the thousands, hunderts etc
# simplified, only need every number once
# so per digit but not the value of the digit
#
class SecretHandshake

  COMMANDS =
    { 1000 => 'jump',
      100 => 'close your eyes',
      10 => 'double blink',
      1 => 'wink'
    }

  def commands(num)
    number = num
    commands_list = []

    COMMANDS.each_key do |wink|
      next if number < wink
      number -= wink
      commands_list << COMMANDS[wink]
    end
    commands_list
  end
end

s = SecretHandshake.new
s.commands(20)

