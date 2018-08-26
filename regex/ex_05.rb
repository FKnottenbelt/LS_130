# using character classes
strings = ['Hoover','hoover','HOOVER']
regex = [/[Hh]oover/]

regex.each do |reg|
   strings.each do |txt|
     p "found match for #{txt} and #{reg}" if txt.match(reg)
     p "No match for #{txt} and #{reg}" if !txt.match(reg)
  end
end

# "found match for Hoover and (?-mix:[Hh]oover)"
# "found match for hoover and (?-mix:[Hh]oover)"
# "No match for HOOVER and (?-mix:[Hh]oover)"