# Passing execution to the block

# method implementation
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say('hi there') do
  system("cls") || system("clear")
end

# clears screen first, then outputs "> hi there"

