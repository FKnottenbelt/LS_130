=begin
For this exercise, we'll be learning and practicing our knowledge
of the arity of lambdas, procs, and implicit blocks. Two groups of
code also deal with the definition of a Proc and a Lambda, and the
differences between the two. Run each group of code below: For your
answer to this exercise, write down your observations for each group
of code. After writing out those observations, write one final
analysis that explains the differences between procs, blocks, and
lambdas.

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

=end


puts " ---- Group 1  --"
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc                  # proc object
puts my_proc.class            # proc
my_proc.call                  # This is a . (thing is nil, param missing ignored)
my_proc.call('cat')           # This is a cat.

puts " ---- Group 2  --"
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda                # proc object (lambda)
puts my_second_lambda         # proc object (lambda)
puts my_lambda.class          # proc
my_lambda.call('dog')         # This is a dog
#my_lambda.call                # wrong number of arguments. strict arity
#my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }
                              # uninitialized constant Lambda (not a class)

puts " ---- Group 3  --"
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."} #This is a . (loose arity)
# block_method_1('seal')   # no block given (yield)

puts " ---- Group 4  --"
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."} # This is a turtle.
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."  # This is a turtle and a .
end
block_method_2('turtle') { puts "This is a #{animal}."} # ndefined local variable or method `animal'
                                     # you do have to specify a block variable |var|
