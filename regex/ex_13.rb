strings = ['Mississippi',
  'ziti 0minimize7',
  'inviting illegal iridium']

regex = [/\b[a-z]*i[a-z]*i[a-z]*i[a-z]*\b/i, /\b([a-z]*i){3}[a-z]*\b/i]

regex.each do |reg|
   strings.each do |txt|
     p reg
     puts "text: #{txt}  "
     p txt.scan(reg)
     puts
  end
end

# nb: quite a difference:
/\b[a-z]*i[a-z]*i[a-z]*i[a-z]*\b/i
text: Mississippi
["Mississippi"]

/\b[a-z]*i[a-z]*i[a-z]*i[a-z]*\b/i
text: ziti 0minimize7
[]

/\b[a-z]*i[a-z]*i[a-z]*i[a-z]*\b/i
text: inviting illegal iridium
["inviting", "iridium"]

#######################

/\b([a-z]*i){3}[a-z]*\b/i
text: Mississippi
[["ppi"]]

/\b([a-z]*i){3}[a-z]*\b/i
text: ziti 0minimize7
[]

/\b([a-z]*i){3}[a-z]*\b/i
text: inviting illegal iridium
[["ti"], ["di"]]