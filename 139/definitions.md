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

about passing blocks, yielding to them
and defering and sandwiching

## Blocks and variable scope
block scope (109) and bindings. overlaps with closure scope?

All normal rules for blocks and scope apply (short version:
Blocks define a separate scope from the main program which can be
thought of as an inner scope. Variables initialized in an outer
scope can be accessed in an inner scope; however, variables
initialized in an inner scope cannot be accessed in an outer scope.)

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
blocks are one way that Ruby implements closures. Closures are a way to pass around an unnamed "chunk of code" to be executed later.

blocks can take arguments, just like normal methods. But unlike normal methods, it won't complain about wrong number of arguments passed to it.

blocks return a value, just like normal methods.

blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.

blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.
===


== Anki voor vb
How does ruby pass blocks that are passed in?
Ruby passes blocks passed in as explicit blocks to a simple Proc object (this is why we need to use #call to invoke the Proc object).

If the argument passed in is already a Proc object or a lambda, Ruby passes it to the method unchanged.

If the argument passed in is neither a block nor a Proc, Ruby calls #to_proc on the object and passes the result to the method.

==