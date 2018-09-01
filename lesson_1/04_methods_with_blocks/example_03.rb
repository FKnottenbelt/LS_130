def echo_with_yield(str)
  yield
  str
end

echo_with_yield("hello") # LocalJumpError: no block given (yield)
echo_with_yield { puts "world"} # wrong number of arguments (given 0, expected 1)
echo_with_yield("hello") { puts "world" } # world => hello

