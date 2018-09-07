# Kernel#block_given?
def echo_with_yield(str)
  yield if block_given?
  str
end

echo_with_yield("hello!")                          # => "hello!"
echo_with_yield("hello!") { puts "world" }         # world
                                                   # => "hello!"