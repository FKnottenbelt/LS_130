# Whitespace character \S en \s

puts "match to whitespace:"
puts 'matched 1' if 'Four score'.match(/\s/)
puts 'matched 2' if "Four\tscore".match(/\s/)
puts 'matched 3' if "Four-score\n".match(/\s/)
puts 'matched 4' if "Four-score".match(/\s/)

=begin
The first three examples in each group all print a matched message
because the given string contains a whitespace character; the last
in each group outputs nothing since "Four-score" doesn't include
whitespace.
=end
puts
puts "match to non-whitespace: "
puts 'matched 1' if 'a b'.match(/\S/)
puts 'matched 2' if " \t\n\r\f\v".match(/\S/)

=begin
prints matched 1 since /\S/ matches each of the letters in 'a b', but
does not print anything for the second match since all of the characters
in the string are whitespace characters.
=end