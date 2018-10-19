# Blocks

## Blocks: Closures and scope
A `closure` is a general programming concept that allows programmers to
save a "chunk of code" and execute it at a later time. They are a way to
pass around an unnamed "chunk of code" to be executed later.

There are three main ways to work with closures in Ruby:
1. Instantiating an object from the Proc classes
2. Using lambdas
3. Using blocks

But because closures can be executed anywhere they are passed to, Ruby has to
keep track of referencs to its surrounding artifacts (ie, variables,
methods, objects, etc) in the outer scope at the moment of the definition
of the closure. We call this the `binding` of the closure.
So the scope of a closure is contained in its `binding` and that is
everything that the block of code can access that is defined somewhere
other than the block.

We can see this in action when looking at the following code:
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"

call_me(chunk_of_code)
```
On `line 6` a proc (closure) is defined and assigned to the local
variable `chunk_of_code`. Ruby applies block scoping rules and 'packs'
all the in scope artifacts into the binding. NB. it packs references to
the variables, not the values.
When the proc is called in `line 2` and the code in the block is executed,
we see that the `puts method` does do indeed reference the current value
of the variable `name` and outputs `"Griffin III"`

> TODO: find quizz question blue to show what happens if it's out of
scope ?

## How blocks work, and when we want to use them.

Blocks are chunks of code you put inside `do` and `end` pair or inside a
`{ ... }` following a method invocation.
```ruby
def my_method   # <== block passed implicitly
  puts "minding my own business and ignoring any blocks"
end

my_method{ puts 'hi' }  # <== method invocation with block

# => "minding my own business and ignoring any blocks"
```
Blocks gets passed to the method of whose invocation they are part of.
They can be passed implicity or explicitly
```ruby
def my_method(&block)   # <== block passed explicitly
  puts "minding my own business and ignoring any blocks"
end

my_method{ puts 'hi' }  # <== method invocation with block

# => "minding my own business and ignoring any blocks"
```

If you want to do something with the block that was passed in implicitly
you can yield to it (it is good practice to check if a block was indeed
passed in by calling Kernel#block_given?).
When you yield to the block, the code in the block is executed and after
the block is finished executing, control is returned to the method:

```ruby
def my_method   # <== block passed implicitly
  yield if block_given?
  puts "doing stuff after the block is finished executing"
end

my_method{ puts 'hi' }  # <== method invocation with block

# => `hi`
# => "doing stuff after the block is finished executing"
```
If you want to do something with a block that was passed explicitly,
you have to call it (since the `&` in the method definition will turn it
into a proc)
```ruby
def my_method(&block)   # <== block passed explicitly
  block.call
  puts "doing stuff after the block is finished executing"
end

my_method{ puts 'hi' }  # <== method invocation with block

# => `hi`
# => "doing stuff after the block is finished executing"
```

Blocks can take arguments and return a value, just like normal methods.
```ruby
[1, 2, 3].select { |num| num.even? }
```
When we yield, we can also pass arguments to the block and/or do
something with the return value. (Methods and blocks will return the
return value of their last evaluated statement.)
```ruby
def my_method
  if block_given?
    result = yield(4)
    puts "the block should return true: #{result}"
  end
end

my_method { |num| num.even? }

# => "the block should return true: true"
```
But unlike normal methods, it won't complain about wrong number of
arguments passed to it.
```ruby
def my_method
  if block_given?
    result = yield(4, 3, 7, 11, 13)   # ignoring extra arguments
    puts "the block should still return true: #{result}"
  end
end

my_method { |num| num.even? }

# => "the block should still return true: true"

def my_method2
  if block_given?
    result = yield   # not enough arguments
    puts "the block outputed an empty line"
  end
end

my_method2 { |num| puts num }

# =>
# => "the block outputed an empty line"
```

Blocks are one way that Ruby implements closures. Closures are a way
to pass around an unnamed "chunk of code" to be executed later.

Blocks are a way to defer some implementation decisions to method
invocation time. It allows method callers to refine a method at
invocation time for a specific use case. It allows method implementors
to build generic methods that can be used in a variety of ways.
```ruby
def do_whatever(input)
  yield(input)
end

do_whatever(0) { puts 'Oh you lazy programmer!' }
do_whatever([1, 2, 3, 4, 5]) { |num| puts num }
```

Blocks are a good use case for "sandwich code" scenarios, like closing
a File automatically.
typical example for opening a file in Ruby is:
```ruby
class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
```

## Blocks and variable scope

Blocks define a separate scope from the main program which can be
thought of as an inner scope. Variables initialized in an outer scope
can be accessed in an inner scope; however, variables initialized in an
inner scope cannot be accessed in an outer scope.

Since a block is how Ruby implements the idea of a closure and in order
for this "chunk of code" to be executed later, it must understand
the surrounding context from when it was initialized. To keep track of
its surrounding context the closure drags its context around wherever the
chunk of code is passed to. In Ruby, we call this its `binding`. This not
only includes local variables, but also method references, constants and
other artifacts. Whatever it needs to execute correctly, it will drag all
of it around.

This is easier to see if you save the block as a proc:
```ruby
def my_method
  yield
end

name = 'Femke'
my_method { puts name }                   #  => Femke

saved_code = Proc.new{ puts name }
name = 'Lisa'

my_method(&saved_code)                    #  => Lisa
```
This is at the core of variable scoping rules in Ruby, and it's why
"inner scopes can access outer scopes"

################ skip this?:

All normal rules that we learned in 101 for blocks and scope apply:
- A block cannot access variables defined in a peer scope
- nested blocks:  blocks can be nested
  - scope can bleed through blocks from out to in
    – a variable initialized outside a block IS available inside the block
    – a variable initialized inside a block IS NOT avaialble outside the block
- `variable shadowing`: If a block takes a parameter, variable shadowing prevents
  access to variables of the same name outside the block
  ```ruby
  n = 4
  [1, 2, 3].each { |n| n + 1 }
  ```
- A do/end pair that does not follow a method invocation does not constitute
  a block, so no nested scope is created

################

## Write methods that use blocks and procs
In Ruby any method can be passed to a block implicitly. The method
can either ignore the block or yield to it. The yield keyword tells
Ruby to execute any block passed to the method during invocation. It
causes execution to jump to the block, execute it, and then jump back
to the method definition and continue on. When yielding to the block
the method can pass parameters to the block and use the return value
of block in its code.
```ruby
def select(array)
  counter = 0
  selected = []
  while counter < array.size
    result = yield(array[counter])
    selected << array[counter] if result
    counter += 1
  end
  selected
end

array = [1, 2, 3, 4, 5]
p select(array)
p select(array) { |num| num.odd? }      # => [1, 3, 5]
```
You may use `Kernel#block_given?` to check if a block was passed in.
Yielding when no block has been passed in will result in a
`LocalJumpError: no block given`

If you want to be able to do things like pass on your block to other
methods from within your methods you could have your method accept
the block explicitly by defining it as the last parameter in your
parameter list and prepending a `&`. This will turn your block into
a proc object that you can either call (to execute the code in the block)
or treat like any other object and do do things like pass it to another
method. Passing blocks in explicitly thus gives you even more
flexibility.
```ruby
def echo(tekst)
  print "echo: "
  tekst.call
end

def alphabet(&block)
  block.call
  echo(block)
end

alphabet{ puts "xyz" }
```

## Methods with an explicit block parameter
eh, repeat above? maybe talk about how it's converted to a proc
and you can call it or pass it on
additional flexibility.
making an implicit block a proc with Proc.new?


## Arguments and return values with blocks
to many, to little arguments > see 'how blocks work'
splat operators and block arguments
return values > see 'how blocks work'


## When can you pass a block to a method
eh.. always?

In Ruby, every method can take an optional block as an implicit
parameter. You can just tack it on at the end of the method invocation.

## &:symbol

A lone & applied to an object causes ruby to try to convert the object to
a block. If that object is a proc, the conversion happens automatically.
If the object is not a proc, then & attempts to call the #to_proc method
on the object first. Used with symbols, e.g., &:to_s, Ruby creates a proc
that calls the #to_s method on a passed object, and then converts that
proc to a block. This is the "symbol to proc" operation calling next
thing to proc. converting into block

Thus this code
```
[1, 2, 3, 4, 5].map(&:to_s)     # turns the symbol into a Proc, then &
                                # turns the Proc into a block

# => ["1", "2", "3", "4", "5"]
```
is the 'shortform' for:
```
[1, 2, 3, 4, 5].map { |nun| num.to_s }
```


# Testing With Minitest

## Testing terminology

`Test Suite`: this is the entire set of tests that accompanies your program
or application. You can think of this as all the tests for a project.

`Test`: this describes a situation or context in which tests are run. For
example, this test is about making sure you get an error message after
trying to log in with the wrong password. A test can contain multiple
assertions.

`Assertion`: this is the actual verification step to confirm that the data
returned by your program or application is indeed what is expected. You
make one or more assertions within a test.

## Minitest vs. RSpec
Minitest is the default testing library that comes with Ruby and the code reads
like normal ruby if we use with its assert-style syntax:
```ruby
require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
```
We can also use Minitest wit a expectation style syntax, so it reads more like
English:
```ruby
require 'minitest/autorun'

require_relative 'car'

describe 'Car#wheels' do
  it 'has 4 wheels' do
    car = Car.new
    car.wheels.must_equal 4           # this is the expectation
  end
end
```

The RSpec gem is a DSL for writing test and its code reads more like natural
English and looks a lot like Minitest expectation style syntax:
```ruby
require 'rspec/autorun'

describe Factorial do
  it "finds the factorial of 5" do
    calculator = Factorial.new
    expect(calculator.factorial_of(5)).to eq(120)
  end
end
```

## SEAT approach
There there are usually 4 steps to writing a test. We call this the
`SEAT` approacg:
- **S**et up the necessary objects.
- **E**xecute the code against the object we're testing.
- **A**ssert the results of the execution.
- **T**Tear down and clean up any lingering artifacts
-
```ruby
class TextTest < MiniTest::Test
  def setup                            # <= Setup
    @file = File.open("starter_file.txt", 'r')
    @text = Text.new(@file.read)
  end

  def test_word_count
    assert_equal(72, @text.word_count) # <= Execute: .word_count &
                                       # <= Assert
  end

  def teardown                         # <= Teardown
    @file.close
    puts "File has been closed: #{@file.closed?}"
  end
end
```

The setup method will be called before running every test, and
the teardown method will be called after running every test.
In the simplest cases, we won't need either set up or tear down.


## Assertions
The `Assertion`is the actual verification step to confirm that the data
returned by your program or application is indeed what is expected. You
make one or more assertions within a test.

There are a lot of different assertions. Some of the most popular are:
Assertion	| Description
--------- | -----------
`assert(test)` | Fails unless `test` is truthy.
`assert_equal(exp, act)` |	Fails unless `exp == act`.
`assert_nil(obj)`	| Fails unless `obj` is `nil`.
`assert_raises(*exp) { ... }` |	Fails unless block raises one of `*exp`.
`assert_instance_of(cls, obj)` |	Fails unless `obj` is an instance of `cls`.
`assert_includes(collection, obj)` | Fails unless `collection` includes `obj`.

example:
```ruby
class CarTest < Minitest::Test
  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def test_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
  end

end
```

# Core Tools/Packaging Code

## Purpose of core tools
The core tools are common tools that help us to build a professional
quality, ready for distribution Ruby project.

> Rubygems

RubyGems, often just called Gems, are packages of code that you can
download, install, and use in your Ruby programs or from the command
line. The gem command manages your Gems.
Examples of gems are: rubocop, pry and rails

> RVM and Rbenv

Ruby version managers are programs that let you install, manage, and
use multiple versions of Ruby. This is usefull:
- if you need other features
- if you work on multiple projects with different ruby versions
The version managers not only let you manage multiple versions of Ruby,
but also the utilities (such as irb) associated with each version, and
the RubyGems installed for each Ruby. With version managers, you can
install and uninstall ruby versions and gems, and run specific
versions of ruby with specific programs and environments.

There are two major ruby version managers in common use: RVM and
rbenv. By default, RVM has more features, but rbenv plugins
provide much of the functionality not provided by the base install
of rbenv. RVM works by dynamically managing your environment, mostly
by modifying your PATH variable and replacing the built-in cd
command with an RVM-aware shell function; rbenv works by just
modifying your PATH and some other environment variables.

> Bundler

Bundler is a dependencies manager. It lets you describe exactly which
Ruby and Gems you want to use with your Ruby apps. Specifically, it
lets you install multiple versions of each Gem under a specific
version of Ruby and then use the proper version in your app.

#### Gemfiles
To use Bundler, you provide a file named Gemfile that describes
the Ruby and Gem versions you want for your app. You use a DSL
described on the Bundler website to provide this information.

example of Gemfile:
```
source 'https://rubygems.org'

ruby '2.3.1'
gem 'sinatra'
gem 'erubis'
gem 'rack'
gem 'rake', '~>10.4.0'
```

Bundler uses the Gemfile to generate a Gemfile.lock file via the
bundle install command. Gemfile.lock describes the actual versions
of each Gem that your app needs, including any Gems that the Gems
listed in Gemfile depend on. The bundler/setup package tells your
Ruby program to use Gemfile.lock to determine which Gem versions
it should load.

example of Gemfile.lock:
```
GEM
  remote: https://RubyGems.org/
  specs:
    erubis (2.7.0)
    rack (1.6.4)
    rack-protection (1.5.3)
      rack
    rake (10.4.2)
    sinatra (1.4.7)
      rack (~> 1.5)
      rack-protection (~> 1.4)
      tilt (>= 1.3, < 3)
    tilt (2.0.5)

PLATFORMS
  ruby

DEPENDENCIES
  erubis
  rack
  rake (~> 10.4.0)
  sinatra

RUBY VERSION
   ruby 2.3.1p112

BUNDLED WITH
   1.13.6
```

> Rake

Rake is a Rubygem that automates many common functions required
to build, test, package, and install programs. With it you can write
Rake tasks to automate anything you may want to do with your application
during the development, testing, and release cycles.

example:
```ruby
require "rake/testtask"
require 'pathname'
require 'find'
require "bundler/gem_tasks"

desc 'Run tests'
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Find not hidden files'
task :find_file do
  path_to_search = '.'
  Find.find(path_to_search) do |file|
    next if name.include?('/.')
    puts file if File.file?(file)
  end
end
```

# Regular Expressions

# The Coding Challenge


===  to order or discard:
block local variable
This is a special type of local variable where the scope is
constrained to the block.

The binding is everything that the block of code can access that is
defined somewhere other than the block.

The binding is actually an object of type Binding.
https://ruby-doc.org/core/Binding.html, but that's an implementation
detail. In more general terms, it's just the everything the block of
code can access without having to define it locally.



find all the in scope bindings for a block (binding object)
with chunk_of_code.binding.local_variables

? see anki: concepts: explain local variable scope and blocks ?

==
===
blocks and procs can both be passed as explicit and implicit arguments.
When passed as implicit arguments, you use yield to invoke the code. When
passed as explicit arguments, you use #call.

== Anki voor vb

==

> How does ruby pass blocks that are passed in?

Ruby passes blocks passed in as explicit blocks to a simple Proc
object (this is why we need to use #call to invoke the Proc object).

If the argument passed in is already a Proc object or a lambda, Ruby
passes it to the method unchanged.

If the argument passed in is neither a block nor a Proc, Ruby calls
#to_proc on the object and passes the result to the method.

> from the forum:

    Closures are not formally defined in the Ruby documentation.
    Thus, you may see some conflicts between what we describe and
    what other sites say. Stick with what we say here in 130 and 139,
    and you should be fine when it counts.

    In Ruby, there are two main forms of closures: procs and lambas.
    For our purposes here at LS, we're can treat blocks as being
    equivalent to anonymous (unnamed) procs, so blocks are also
    closures.

    For our purposes, blocks, procs, and lambdas are all the ways
    that Ruby forms closures.

    Blocks are the most common way Ruby developers deal with closures.

    In the summary, we say that methods can sometimes be closures. In
    a sense, that's true, but it's not worth bringing up in this
    course, so we're going to delete that.

    Closures do not have to be assigned to a variable (a block is not
    assigned to a variable).

    Blocks are not objects.