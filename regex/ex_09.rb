# match returns a truthy value when there is a match anywhere in the string.
# Though Rubular shows /[^x]/ matching the y in xyx and nothing else, text.match
# is still truthy.

text = 'xyx'
puts 'matched' if text.match(/[^x]/)

# matched
