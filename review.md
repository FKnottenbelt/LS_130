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

# code
probably try writing at least one `each` etc for hash and set?
(see sets)
see also ~/130/lesson_2_testing/09_more_topics/easy2/07_each_with_object.rb

# testing: assertion syntax (more variation then in lessons)
~/130/lesson_2_testing/09_more_topics/easy_testing