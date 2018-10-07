=begin
Write a program that given a phrase can count the occurrences of
each word in that phrase.

For example, if we count the words for the input "olly olly in come
free", we should get:

olly: 2
in: 1
come: 1
free: 1
=end

=begin
i: string (phrase)
o: hash { word => no_of_occurences }. keys should be lowercase
p: count the no of occurences of each word in a give phrase
r: discount punctuation
   deal with lack of spaces (so split on real words)
   deal with extra whitespace characters (so split on real words)
   a number is a word too
   wordt count should ignore case (Ab == AB)
   single quote that is not at beginning or end of string is part of word
a: split phrase into true words. all lowercase
   loop through words in phrase
    count to hash
   return hash
=end

class Phrase
  attr_reader :words

  def initialize(phrase)
    @words = split_to_words(phrase)
  end

  def word_count
    count = Hash.new{0}
    words.each do |word|
      count[word] += 1
    end
    count
  end

  private

  def split_to_words(phrase)
    whole_word_regex = /\b[\w']+\b/
    phrase.scan(whole_word_regex).map(&:downcase)
  end
end

# top solutions
class Phrase
  def initialize(words)
    @words = words
  end

  def word_count
    count = Hash.new(0)

    @words.scan(/\b[\w']+\b/) do |word|
      count[word.downcase] += 1
    end

    count
  end
end

class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words_in_phrase.each_with_object(Hash.new(0)) do |word, results|
      results[word] += 1
    end
  end

  private

  def words_in_phrase
    @phrase.downcase.scan(/\w+'?\w+|\w+/)
  end
end

class Phrase
  def initialize(phrase)
    @words = phrase.downcase.scan(/[a-z]+'?[a-z]+|\d+/)
  end

  def word_count
    @words.each_with_object(Hash.new(0)) do |word, results|
      results[word] += 1
    end
  end
end
