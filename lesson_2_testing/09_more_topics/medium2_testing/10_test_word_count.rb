=begin

Test word_count method - Text

Recall that in the last exercise we only had to test one method
of our Text class. One of the useful facets of the setup and
teardown methods is that they are automatically run before
and after each test respectively. To show this we'll be adding
one more method to our Text class, word_count.

class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end

Write a test for this new method. Make sure to utilize the
setup and teardown methods for any file related operations.
=end