=begin
Challenge: write a regex that matches a string that looks like a simple
negated character class range, e.g., '[^a-z]'. (Your answer should
match precisely six characters.)

Test it with these strings:

The regex /[^a-z]/i matches any character that is
not a letter. Similarly, /[^0-9]/ matches any
non-digit while /[^A-Z]/ matches any character
that is not an uppercase letter. Beware: /[^+-<]/
is at best obscure, and may even be wrong.

There should be three matches.
=end

strings = ["The regex /[^a-z]/i matches any character that is
not a letter. Similarly, /[^0-9]/ matches any
non-digit while /[^A-Z]/ matches any character
that is not an uppercase letter. Beware: /[^+-<]/
is at best obscure, and may even be wrong."]

regex = [ /\[\^[0-9A-Za-z]-[0-9A-Za-z]\]/,
 /[\[][\^][0-9A-Za-z]-[0-9A-Za-z][\]]/ ]

regex.each do |reg|
   strings.each do |txt|
     p reg
     #puts "text: #{txt}  "
     p txt.scan(reg)
     puts
  end
end

# => ["[^a-z]", "[^0-9]", "[^A-Z]"]

=begin
There are six patterns in each of these regex:

Pattern     	Explanation

\[ or [\[] 	  a literal [
\^ or [\^] 	  a literal ^
[0-9A-Za-z] 	any of the usual character class range starting values
- 	          a literal '-'
[0-9A-Za-z] 	any of the usual character class range ending values
\] or [\]] 	  a literal ]

The three matches are /[^a-z]/i, /[^0-9]/, and /[^A-Z]/. Technically,
the last regex string in our sample text, /[^+-<]/, is a valid regex;
there is nothing illegal about character class ranges that don't use
alphanumeric starting and ending points. However, you should avoid
such ranges; think of them as invalid.

=end