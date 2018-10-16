=begin

Pig Latin

Pig Latin is a made-up children's language that's intended to be confusing.
It obeys a few simple rules (below), but when it's spoken quickly it's
really difficult for non-children (and non-native speakers) to understand.

    Rule 1: If a word begins with a vowel sound, add an "ay" sound to the
    end of the word.
    Rule 2: If a word begins with a consonant sound, move it to the end of
    the word, and then add an "ay" sound to the end of the word.

There are a few more rules for edge cases, and there are regional variants
too.

=end

=begin
input: word or sentence
ouput: transformed word or sentence

translation rules:
-  vowel => word + ay
-  xr => word + ay
-  yt => word + ay

-  sch => sch to end + ay
-  thr => thr to end + ay
-  consonant plus qu => consonant plus qu to end + ay

-  ch => ch to end + ay
-  th => th to end + ay
-  qu => qu to end + ay

-  consonant => move to end + ay

=end

class PigLatin
  def self.translate(words)
    words.split.map do |word|
      transform(word)
    end.join(' ')
  end

  private

  def self.transform(word)
    return word + 'ay'  if word =~ /\b([aeiou]|xr|yt)/
    return word.chars.rotate(3).join + 'ay' if word =~ /\b(sch|thr|[^eaiou]qu)/
    return word.chars.rotate(2).join + 'ay' if word =~ /\b(ch|th|qu)/
    return word.chars.rotate(1).join + 'ay' if word =~ /\b[^aeiou]/
  end
end

# ls solution
class PigLatin
  def self.translate(phrase)
    phrase.split(' ').map do |word|
      translate_word(word)
    end.join(' ')
  end

  def self.translate_word(word)
    if begins_with_vowel_sound?(word)
      word + 'ay'
    else
      consonant_sound, the_rest_of_word = parse_for_consonant(word)
      the_rest_of_word + consonant_sound + 'ay'
    end
  end

  def self.begins_with_vowel_sound?(word)
    word.match(/\A[aeiou]|[xy][^aeiou]/)
  end

  def self.parse_for_consonant(word)
    consonant_split = /\A([^aeiou]*qu|[^aeiou]+)([aeiou].*)\z/.match(word)
    [consonant_split[1], consonant_split[2]]
  end
end

