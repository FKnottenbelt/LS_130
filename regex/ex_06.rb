# concatenate character classes
strings = ['a2','Model 640c1','a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3']
regex = [/[abc][12]/]

regex.each do |reg|
   strings.each do |txt|
     p reg
     puts "text: #{txt}  "
     p txt.scan(reg)
     puts
  end
end

# /[abc][12]/
# text: a2
# ["a2"]

# /[abc][12]/
# text: Model 640c1
# ["c1"]

# /[abc][12]/
# text: a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3
# ["a1", "a2", "b1", "b2", "c1", "c2"]