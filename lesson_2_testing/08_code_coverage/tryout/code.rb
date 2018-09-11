require 'forwardable'


class Book
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end
end

class Library
  extend Forwardable

  def_delegators :@books, :<<, :size

  def initialize
    @books = []
  end

  # def size
  #   @books.size
  # end
end
