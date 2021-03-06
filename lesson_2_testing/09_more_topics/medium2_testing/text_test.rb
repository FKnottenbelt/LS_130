require 'minitest/autorun'
require_relative 'text'

class TextTest < MiniTest::Test
  def setup
    @file = File.open("starter_file.txt", 'r')
    @text = Text.new(@file.read)
  end

  def test_swap
    # test that all a's are transformed in e's
    # so there should be no e's anymore
    # and a random sample with 'a' should now be 'e':
    # pharetra is now pheretre

    # return value swap should be the text
    refute_match(/[a]/, @text.swap('a','e'))
    assert_match(/pheretre/, @text.swap('a','e'))
  end

  def test_word_count
    assert_equal(72, @text.word_count)
  end

  def teardown
    @file.close
    puts "File has been closed: #{@file.closed?}"
  end
end