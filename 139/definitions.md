# Blocks

## Blocks: Closures and scope

A `closure` is a general programming concept that allows programmers to
save a "chunk of code" and execute it at a later time. They are a way to
pass around an unnamed "chunk of code" to be executed later.

There are three main ways to work with closures in Ruby (or `Proc object`):
1. Instantiating an object from the Proc classes
2. Using lambdas
3. Using blocks

All normal rules for blocks and scope apply (short version:
Blocks define a separate scope from the main program which can be
thought of as an inner scope. Variables initialized in an outer
scope can be accessed in an inner scope; however, variables
initialized in an inner scope cannot be accessed in an outer scope.)

But because closures can be executed anywhere they are passed to, Ruby has to
keep track of referencs to the variables in the outer scope at the moment
of the definition of the closure. We call this the binding of the closure.
So the scope of a closure is contained in its `binding` and that is
everything that the block of code can access that is defined somewhere
other than the block.

We can see this in action when looking at the following code:
```ruby
require 'pry'

message = 'nice to see you'

def call_me(some_code)
  binding.pry
  some_code.call
end

message = 'goodbye'
name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}, #{message}"}
name = "Griffin III"

call_me(chunk_of_code)
message = 'call you soon'
```
On line 11 a proc (closure) is defined and assigned to the local
variable `chunk_of_code`. Ruby applies block scoping rules and 'packs'
all the in scope variables into the binding. NB. it packs references to
the variables, not the values.
If we examine the proc just before it is called in line 34 by going
into pry and calling pry on the proc, we get to see the definition of
the proc and if we then ask pry for the values of `name` and
`message` we see that they do indeed reference the current value of
these variables:

```ruby
    11: def call_me(some_code)
    12:   binding.pry
 => 13:   some_code.call
    14: end

[1] pry(main)> some_code.pry
```
```ruby
From: /home/ec2-user/environment/temp.rb @ line 18 :

    13:   some_code.call
    14: end
    15:
    16: message = 'goodbye'
    17: name = "Robert"
 => 18: chunk_of_code = Proc.new {puts "hi #{name}, #{message}"}
    19: name = "Griffin III"
    20:
    21: call_me(chunk_of_code)
    22: message = 'call you soon'

[1] pry(main)> name
=> "Griffin III"
[2] pry(main)> message
=> "goodbye"
[3] pry(main)> exit-program
```

## How blocks work, and when we want to use them.

about passing blocks, yielding to them
and defering and sandwiching

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
blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.

blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it.

blocks return a value, just like normal methods.

blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.

blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.
===


    Blocks and variable scope
    Write methods that use blocks and procs
    Methods with an explicit block parameter
    Arguments and return values with blocks
    When can you pass a block to a method
    &:symbol

== Anki voor vb
How does ruby pass blocks that are passed in?
Ruby passes blocks passed in as explicit blocks to a simple Proc object (this is why we need to use #call to invoke the Proc object).

If the argument passed in is already a Proc object or a lambda, Ruby passes it to the method unchanged.

If the argument passed in is neither a block nor a Proc, Ruby calls #to_proc on the object and passes the result to the method.

==