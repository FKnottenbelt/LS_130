require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'code'

class LibraryTest < MiniTest::Test
  def setup
    @lib = Library.new
    @book1 = Book.new("This brave new world")
    @book2 = Book.new("Programming Ruby")
  end

  def test_book_to_s
    assert_equal("This brave new world" ,@book1.to_s)
  end
end

# so if you use forwardable you don't have to write tests for the
# delegated methods. You do need to write tests if you handcode them.
