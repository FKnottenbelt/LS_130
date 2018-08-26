# Character class patterns use a list of characters between
# square brackets
strings = ['Four score + seven.']
regex = [/[e+]/,/[FX]/,/[abAB]/,/[*+]/]

regex.each do |reg|
   strings.each do |txt|
     p "found match for #{txt} and #{reg}" if txt.match(reg)
     p "No match for #{txt}and #{reg}" if !txt.match(reg)
  end
end

# "found match for Four score + seven. and (?-mix:[e+])"
# "found match for Four score + seven. and (?-mix:[FX])"
# "No match for Four score + seven.and (?-mix:[abAB])"
# "found match for Four score + seven. and (?-mix:[*+])"