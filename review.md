# talking about code
01-04 'Passing execution to the block'
01-04 'Yielding with an argument'
01-05

# block variable scope
01-14

how to I see (in pry) what the bindings of a proc
are? Can I inspect it somehow? yep:
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"
call_me(chunk_of_code)
puts
a = 3
chunk_of_code.pry  # <== call pry on your proc!
```
pry will show the place where your proc was
defined. Querying its vars will show you its current
value. NEAT!
```ruby
    13:
    14: name = "Robert"
 => 15: chunk_of_code = Proc.new {puts "hi #{name}"}
    16: name = "Griffin III"
    17: call_me(chunk_of_code)
    18: puts
    19: a = 3
    20: chunk_of_code.pry

```
asking for name will tell you "Griffin III"

Even better: just call pry on your proc when in pry
(so call in pry in pry):
```

     8: def call_me(some_code)
     9:   binding.pry
 => 10:   some_code.call
    11: end

[1] pry(main)> some_code.pry

From: /home/ec2-user/environment/temp.rb @ line 14 :

     9:   binding.pry
    10:   some_code.call
    11: end
    12:
    13: name = "Robert"
 => 14: chunk_of_code = Proc.new {puts "hi #{name}"}
    15: name = "Griffin III"
    16: call_me(chunk_of_code)
    17: puts
    18: a = 3

[1] pry(main)> name
=> "Griffin III"
```

# blocks summery 01-16

# passing blocks
anki cards on procs
01-15, 01-04, 01-f1, block_notes

# testing  (?)
Is it wise to use custom methods to test other custom methods?
should we use .instance_variable_get instead to get at the inner
variable?
And do we test inside the method or just return values? (~/130/lesson_2_testing/09_more_topics/medium2_testing/02_setup_test_cash_register.rb)

Pete hanson: With blocks, test that your blocks are being invoked when
they should be, and that the return values are being used the way you
intend.

# HEREDOC (?)
squiggly heredoc to remove preceding spaces ?

# rubocop
run rubocop on lots of block exercises and versions of
todolist

# Sets
Sets? ~/130/lesson_2_testing/09_more_topics/easy2/03_map.rb
http://ruby-doc.org/stdlib-2.4.0/libdoc/set/rdoc/Set.html

# smalls
~/130/lesson_2_testing/09_more_topics/easy2/05_drop_while.rb (go for performance)
~/130/lesson_2_testing/09_more_topics/easy2/07_each_with_object.rb
~/130/lesson_2_testing/09_more_topics/easy2/08_max_by.rb
~/130/lesson_2_testing/09_more_topics/easy2/10_each_cons2.rb
~/130/lesson_2_testing/09_more_topics/medium1/02_text_analyser.rb
~/130/lesson_2_testing/09_more_topics/medium1/04_passing_parameters2.rb
~/130/lesson_2_testing/09_more_topics/medium1/05_passing_parameter3.rb
~/130/lesson_2_testing/09_more_topics/medium2_testing/06_transaction_payment_prompt.rb
basically all medium2_testing are good reminder excerises

# code
probably try writing at least one `each` etc for hash and set?
(see sets)
see also ~/130/lesson_2_testing/09_more_topics/easy2/07_each_with_object.rb

# testing: assertion syntax (more variation then in lessons)
~/130/lesson_2_testing/09_more_topics/easy_testing

# ?
~/130/lesson_2_testing/09_more_topics/medium1/06_method_to_proc.rb

# testing user input
using StringIO for $stdin
~/130/lesson_2_testing/09_more_topics/medium2_testing/06_transaction_payment_prompt.rb

# testing output strings
~/130/lesson_2_testing/09_more_topics/medium2_testing/05_register_give_receipt.rb
see also HEREDOC
~/130/lesson_2_testing/09_more_topics/medium2_testing/06_transaction_payment_prompt.rb

# Input & output in Ruby
http://zetcode.com/lang/rubytutorial/io/

# rubocop
get easy access to original rubocop file 120 (no changed ruby version?)

# rubygems
RubyGems, or Gems for short, are packages of code that you can
download, install, and use in your Ruby programs or from the
command line. The gem command manages your Gems.


# Ruby version managers
Ruby version managers are programs that let you install, manage,
and use multiple versions of Ruby
- if you need other features
- if you work on multiple projects with different ruby versions
There are two major ruby version managers in common use: RVM and
rbenv
see summary in book

# challenges
check out a video?

# regex
final excerises

# Bundler
Dealing with dependencies -- multiple versions of Ruby and
multiple versions of Gems -- is a significant issue in Ruby.
dependency issues arise in all languages.

You can also use your version manager to manage Gem dependencies,
but the favored approach is to use a dependency manager.

The most widely used dependency manager in the Ruby community,
by far, is the Bundler Gem. This Gem lets you configure
which Ruby and which Gems each of your projects need.

If you use a Ruby version manager, you must install the Gem in
each version of Ruby for which you wish to use Bundler.

After you create `Gemfile`, the `bundle install` command scans it,
downloads and installs all the dependencies listed, and produces
a `Gemfile.lock` file. Gemfile.lock shows all the dependencies
for your program

Once Bundler creates your Gemfile.lock, add:
```
require 'bundler/setup'
```
to the beginning of your app, before any other Gems. (This is
unneeded if your app is a Rails app).

also see summary in book
