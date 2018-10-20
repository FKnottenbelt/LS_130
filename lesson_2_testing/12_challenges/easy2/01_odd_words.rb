=begin

Odd Words and the How to Work with a Code Challenge

We did a live problem solving session and used the "Odd Words" problem to
talk about the general process of working through a live code challenge.

Unlike other challenges, this one doesn't come with a complete test suite,
so you have to work out your own examples(you don't have to write the
actual tests, just example inputs and outputs). You can watch the first
10 minutes of the video on the general process and the problem itself,
try to work on the problem, and fast foward to 47:20 or so when we discuss
the solutions.

problem:
Consider a character set consisting of letters, a space, and a point
Words consist of one or more, but at most 20 letters. An input text
consists of one or more words sperated from each other by one or more
spaces and terminated by 0 or more spaces followed by a point. The input
should be read from, and including, the first letter of the first word,
up to and including the terminating point. The output text is to be
produced such that succesive words are seperated by a single space with
the last word being terminiated by a single point. Odd words are copied
in reverse order while even words are merely echoed. For example, the
input string
'whats the matter with kansas.' becomes 'whats eht matter htiw kansas.'

bonus points: the characters must be read and printed one at a time.
=end

=begin
input: sentence. words are max 20 letters separated by space(s) and
 sentence end in point.
output: sentence. words seprated by single space
r: odd words are reversed, even words copied as is.
a: raise error on : - non valid characters
                    - no terminiation point
   return empty string when empty

   remove terminating point
   split into words with index (thus removing extra spaces)
   when odd index, reverse word, else copy
   join with space.
   add termination point

   bonus:
   initialize word counter to 0
   initialize letter counter to
   0
   initialize output array
   split sentence into chars
     if last output was space, and this is a space, next
     if even word letter, add to ouput
     if this is space, increase word counter
     if uneven word letter insert in reverse order unless space or point
=end

def valid?(sentence)
  invalid_chars = sentence.match(/[^A-Za-z. ]/)
  valid_termination = !!(sentence[-1] == ".")
  !invalid_chars && valid_termination
end

def odd_words(sentence)
  return "" if sentence.empty?
  return "not valid input" if !valid?(sentence)
  sentence = sentence[0...-1]

  sentence.split.map.with_index do |word, ind|
    ind.odd? ? word.reverse : word
  end.join(' ') + "."

end

p odd_words("whats the matter with kansas.") == "whats eht matter htiw kansas."
p odd_words("whats    the matter   with k.") == "whats eht matter htiw k."
p odd_words("") == ""
p odd_words("&^%#*") == "not valid input"
p odd_words("Hello HELLO and yOu.") == "Hello OLLEH and uOy."
p odd_words('hello') == "not valid input"
p odd_words('hello.') == 'hello.'
p odd_words("whats    the matter   with kansas  .") == "whats eht matter htiw kansas."
p odd_words("what's the matter?") == "not valid input"

def odd_words_bonus(sentence)
  return "" if sentence.empty?
  return "not valid input" if !valid?(sentence)

  word_counter = 0
  letter_counter = 1
  transformed_sentence = []

  sentence.chars.each do |char|
    next if transformed_sentence.last == ' ' && char == ' '

    if word_counter.even?
      transformed_sentence << char
    else
      transformed_sentence.insert(-letter_counter, char) if char != " " && char != '.'
      transformed_sentence << char if char == ' ' || char == '.'
      letter_counter += 1
    end

    word_counter += 1 if char == ' '
    letter_counter = 1 if char == ' '
  end
  transformed_sentence.join
end

p odd_words_bonus("whats the matter with kansas.") == "whats eht matter htiw kansas."
p odd_words_bonus("whats    the matter   with k.") == "whats eht matter htiw k."
p odd_words_bonus("") == ""
p odd_words_bonus("&^%#*") == "not valid input"
p odd_words_bonus("Hello HELLO and yOu.") == "Hello OLLEH and uOy."
p odd_words_bonus('hello') == "not valid input"
p odd_words_bonus('hello.') == 'hello.'
p odd_words_bonus("whats    the matter   with kansas  .") == "whats eht matter htiw kansas ."
p odd_words("what's the matter?") == "not valid input"