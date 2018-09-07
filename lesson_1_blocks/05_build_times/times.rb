# original
# 5.times do |num|
#   puts num
# end

# method implementation
def times(number)
  counter = 0
  loop do
    break if counter == number
    yield(counter)
    counter += 1
  end
  number
end

# this should give same

times(5) do |num|
  puts num
end

# ls
# method implementation
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  number   # return the original method argument to
           # match behavior of `Integer#times`
end

# method invocation
times(5) do |num|
  puts num
end