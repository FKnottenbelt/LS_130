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
something with the return value.
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

Since a block is how Ruby implements the idea of a closure and in order
for this "chunk of code" to be executed later, it must understand
the surrounding context from when it was initialized. To keep track of
its surrounding context the closure drags its context around wherever the
chunk of code is passed to. In Ruby, we call this its `binding`, or
surrounding environment/context. This not only includes local variables,
but also method references, constants and other artifacts. Whatever it
needs to execute correctly, it will drag all of it around.

> fix tekst.. 

normal block has seemlingly normal scope. if you save block you
can really see closures at work. (since you can't change name after
calling block...hard to see)
```ruby
def my_method
  yield
end

name = 'Femke'
my_method { puts name }
saved_code = Proc.new{ puts name }
name = 'Lisa'
my_method(&saved_code)
```
It's why code like the above will work fine, seemingly violating the
variable scoping rules we learned earlier.

This is at the core of variable scoping rules in Ruby, and it's why
"inner scopes can access outer scopes"

## Write methods that use blocks and procs
implicit blocks and explicit blocks
testing for block with Kernel#block_given?
yielding and calling
returning to method

sandwich and defering example

## Methods with an explicit block parameter
eh, repeat above? maybe talk about how it's converted to a proc
and you can call it or pass it on
additional flexibility.
making an implicit block a proc with Proc.new?

## Arguments and return values with blocks
to many, to little arguments
splat operators and block arguments
return values? get used? (figure out what ls means)


Methods and blocks will return the return value of their last evaluated statement.

    Blocks can take arguments, just like normal methods. But unlike normal methods, it won’t complain about wrong number of arguments passed to it.

    Blocks return a value, just like normal methods.

    When we yield, we have to be aware of the block’s return value.

## When can you pass a block to a method
eh.. always?

In Ruby, every method can take an optional block as an implicit parameter. You can just tack it on at the end of the method invocation.

## &:symbol
calling next thing to proc. converting into block
full form vs short form


# Testing With Minitest

    Testing terminology
    Minitest vs. RSpec
    SEAT approach
    Assertions

# Core Tools/Packaging Code

    Purpose of core tools
    Gemfiles
# Regular Expressions

# The Coding Challenge
===
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


== Anki voor vb

==

> How does ruby pass blocks that are passed in?

Ruby passes blocks passed in as explicit blocks to a simple Proc
object (this is why we need to use #call to invoke the Proc object).

If the argument passed in is already a Proc object or a lambda, Ruby
passes it to the method unchanged.

If the argument passed in is neither a block nor a Proc, Ruby calls
#to_proc on the object and passes the result to the method.