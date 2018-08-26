# using character classes
strings = ['3','y']
regex = [/[12345]/,/[nyNY]/]

regex.each do |reg|
   strings.each do |txt|
     p "found match for #{txt} and #{reg}" if txt.match(reg)
     p "No match for #{txt} and #{reg}" if !txt.match(reg)
  end
end
