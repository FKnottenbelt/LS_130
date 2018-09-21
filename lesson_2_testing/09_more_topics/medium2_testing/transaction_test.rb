require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < MiniTest::Test
  def setup
    @transaction = Transaction.new(50)
  end

  # nb: need to have parameter input: $stdin
  # and redirect gets to input.gets
  def test_prompt_for_payment_correct_amount
    input = StringIO.new("50\n")
    @transaction.prompt_for_payment(input: input)
    assert_equal 50, @transaction.amount_paid
  end

  # def test_prompt_for_payment_paying_incorrect_amount
  #   input = StringIO.new("20\n50") # second time correct to get out of loop
  #   $stdout = StringIO.new
  #   @transaction.prompt_for_payment(input: input)
  #   assert_match(/That is not the correct amount/, $stdout.string)
  #   $stdout = STDOUT
  # end

  # this needs method in transaction to have output: $stdout paramater
  # and to do output.puts in stead of puts
  def test_prompt_for_payment_correct_amount #no_output: exercise 7
    input = StringIO.new("50\n")
    output = StringIO.new # mocking $stdout
    @transaction.prompt_for_payment(input: input, output: output)
    assert_equal 50, @transaction.amount_paid
  end

  def test_prompt_for_payment_correct_amount # homemade capture io
    input = StringIO.new("50\n")
    $stdout = StringIO.new
    @transaction.prompt_for_payment(input: input)
    $stdout = STDOUT
    assert_equal 50, @transaction.amount_paid
  end

  def test_prompt_for_payment_correct_amount # capture Io version
    input = StringIO.new("50\n")
    #$stdout = StringIO.new
    capture_io { @transaction.prompt_for_payment(input: input) }
    #$stdout = STDOUT
    assert_equal 50, @transaction.amount_paid
  end

  def test_prompt_for_payment_correct_amount
    $stdin = StringIO.new("50\n")
    $stdout = StringIO.new
    @transaction.prompt_for_payment
    $stdout = STDOUT
    $stdin = STDIN
    assert_equal 50, @transaction.amount_paid
  end

  def test_prompt_for_payment_paying_incorrect_amount
    $stdin = StringIO.new("20\n50") # second time correct to get out of loop
    $stdout = StringIO.new
    @transaction.prompt_for_payment
    assert_match(/That is not the correct amount/, $stdout.string)
    $stdout = STDOUT
    $stdin = STDIN
  end
end
