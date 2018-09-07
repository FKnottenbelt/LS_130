# method definition takes parameters
def echo(str)
  str
end

echo # irb: ArgumentError: wrong number of arguments (given 0, expected 1)
echo("hello") # irb  => "hello"
echo("hello",'world') # irb: ArgumentError: wrong number of arguments (given 2, expected 1)

# this time, called with an implicit block
echo {puts "world"} # irb: ArgumentError: wrong number of arguments (given 0, expected 1)
echo("hello") { puts "world"} # irb:  => "hello"
echo("hello") {"world"} # irb:  => "hello"
echo("hello", "world!") { puts "world" }  # (irb):wrong number of arguments (given 2, expected 1)


