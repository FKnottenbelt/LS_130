=begin
Anagrams

Write a program that, given a word and a list of possible anagrams,
selects the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like
"enlists" "google" "inlets" "banana" the program should return a list
containing "inlets". Please read the test suite for exact rules of
anagrams.
=end

=begin
i: word and list of words
p: match word to anagrams in list of words
  listen vs (enlist, google, inlets, banana) => inlets, enlist
r: anagram should countain the same letters as input word
   anagram should not equal input word
   anagram is case insensitive when comparing, but output has same
   case as the possible anagram had when inputed
o: array of anagrams to input word
a: for each possible anagram
     skip if possible anagram equals input word (case insensitive)
     compare word characters to possible anagram characters (case
     insensitive)
     if exact match, add possible anagram to anagram array
   return anagram array
=end

class Anagram
  attr_reader :word
  def initialize(word)
    @word = word.downcase
  end

  def match(possible_anagrams)
    anagrams = []
    possible_anagrams.each do |candidate|
      next if candidate.downcase == word
      anagrams << candidate if anagram?(candidate.downcase)
    end
    anagrams
  end

  private

  def anagram?(candidate)
    candidate.chars.sort == word.chars.sort
  end
end

# detector = Anagram.new('listen')
# p detector.match(%w(enlist google inlets banana))

# top solutions
class Anagram
  def initialize word
    @original_word = word
    @letters = letters @original_word
  end

  def match possibilities
    possibilities.sort.select { |word| anagram? word }
  end

  private

  def anagram? word
    @letters == letters(word) && @original_word != word.downcase
  end

  def letters word
    word.downcase.chars.sort
  end
end

class Anagram
  attr_reader :word, :letters

  def initialize(word)
    @word = word.downcase
    @letters = @word.chars.sort
  end

  def sorted_letters(str)
    str.downcase.chars.sort
    #yeah I could have just put this in my select block, but this looks nicer
  end

  def match(word_array)
    word_array.select { |ana| sorted_letters(ana) == letters && ana.downcase != word }
  end
end

class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(words)
    words.select { |word| anagrams?(word) }
  end

  def anagrams?(word)
    word.downcase != @word &&
    word.downcase.chars.sort == @word.chars.sort
  end
end
