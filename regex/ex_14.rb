=begin
Write a method that returns true if its argument looks like a URL,
false if it does not.

p url?('http://launchschool.com')   == true
p url?('https://example.com')       == true
p url?('https://example.com hello') == false
p url?('   https://example.com')    == false
=end

def url?(string)
  !!string.match(/\Ahttps?:\/\/[a-z]*[.]{1}com\z/)
end

p url?('http://launchschool.com')   == true
p url?('https://example.com')       == true
p url?('https://example.com hello') == false
p url?('   https://example.com')    == false


# ls solution
def url?(text)
  !!text.match(/\Ahttps?:\/\/\S+\z/)
end
# Note that we use !! to coerce the result of our match
# call to a boolean value.