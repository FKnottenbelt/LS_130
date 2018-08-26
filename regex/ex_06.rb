# concatenate character classes
strings = ['a2','Model 640c1','a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3']
regex = [/[abc][12]/]

regex.each do |reg|
   strings.each do |txt|
     p "found match for #{txt} and #{reg}" if txt.match(reg)
     p "No match for #{txt} and #{reg}" if !txt.match(reg)
  end
end

# "found match for a2 and (?-mix:[abc][12])"
# "found match for Model 640c1 and (?-mix:[abc][12])"
# "found match for a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3 and (?-mix:[abc][12])"