# Negated Classes
# 'any character that is not' means exactly that: ANY character

strings = ['Four Score And Seven',
  'abcdefghijklmnopqrstuvwxyz',
  '123 hello +/* bye']

regex = [/[^aeiou]/]

regex.each do |reg|
   strings.each do |txt|
     p reg
     puts "text: #{txt}  "
     p txt.scan(reg)
     puts
  end
end

# /[^aeiou]/
# text: Four Score And Seven
# ["F", "r", " ", "S", "c", "r", " ", "A", "n", "d", " ", "S", "v", "n"]

# /[^aeiou]/
# text: abcdefghijklmnopqrstuvwxyz
# ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]

# /[^aeiou]/
# text: 123 hello +/* bye
# ["1", "2", "3", " ", "h", "l", "l", " ", "+", "/", "*", " ", "b", "y"]