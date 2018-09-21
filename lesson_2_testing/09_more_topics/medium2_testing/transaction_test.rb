require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < MiniTest::Test
  def setup
    @transaction = Transaction.new(50)
  end

  def test_prompt_for_payment_correct_amount
    input = StringIO.new("50\n")
    @transaction.prompt_for_payment(input: input)
    assert_equal 50, @transaction.amount_paid
  end

  def test_prompt_for_payment_paying_incorrect_amount
    input = StringIO.new("20\n50") # second time correct to get out of loop
    $stdout = StringIO.new
    @transaction.prompt_for_payment(input: input)
    assert_match(/That is not the correct amount/, $stdout.string)
    $stdout = STDOUT
  end
end
