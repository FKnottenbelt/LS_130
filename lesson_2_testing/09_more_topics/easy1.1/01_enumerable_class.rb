=begin
Assume we have a Tree class that implements a binary tree.

class Tree
  ...
end

A binary tree is just one of many forms of collections, such as Arrays,
Hashes, Stacks, Sets, and more. All of these collection classes include
the Enumerable module, which means they have access to an each method,
as well as many other iterative methods such as map, reduce, select, and more.

For this exercise, modify the Tree class to support the methods of Enumerable.
You do not have to actually implement any methods -- just show the methods
that you must provide.
=end


class Tree
  include Enumerable

  def each; end

  def <=>; end
end

=begin
See the paragraph at the top of the documentation for Enumerable, for help.
After including the Enumerable module, the Tree#each and Tree#<=> methods
will provide the underlying functionality necessary for the Enumerable
instance methods to work on Tree objects.
=end