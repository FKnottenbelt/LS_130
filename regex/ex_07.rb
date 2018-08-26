# don't try to combine lowercase and uppercase alphabetic
# characters in a single range


strings = ['The United Nations',
  'The [eval] method',
  'Some^weird_stuff']

regex = [/[A-z]/]

regex.each do |reg|
   strings.each do |txt|
     p reg
     puts "text: #{txt}  "
     p txt.scan(reg)
     puts
  end
end