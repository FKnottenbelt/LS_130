# Blocks

## Blocks: Closures and scope

A `closure` is a general programming concept that allows programmers to save a
"chunk of code" and execute it at a later time. They are a way to pass around an
unnamed "chunk of code" to be executed later.

There are three main ways to work with closures in Ruby (or `Proc object`):
1. Instantiating an object from the Proc classes
2. Using lambdas
3. Using blocks

All normal rules for blocks and scope apply (short version:
Blocks define a separate scope from the main program which can be
thought of as an inner scope. Variables initialized in an outer
scope can be accessed in an inner scope; however, variables
initialized in an inner scope cannot be accessed in an outer scope.)

Since closures can be executed anywhere they are passed to, Ruby has to keep track
of referencs to the variables in the outer scope at the moment of the definition of
the closure. We call this the binding of the closure. So the scope of a closure is
contained in its `binding` and that is everything that the block of code can access
that is defined somewhere other than the block.

We can see this in action when looking at the following code:
```ruby
def abc
  a = 3
end

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"

p chunk_of_code.binding.local_variables
call_me(chunk_of_code)
```
On line 6 a proc (closure) is defined and assigned to the local
variable `chunk_of_code`
When we ask the proc on line 9 for its bindings
NOPE, doesn't show abc in scope....


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

    How blocks work, and when we want to use them.
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