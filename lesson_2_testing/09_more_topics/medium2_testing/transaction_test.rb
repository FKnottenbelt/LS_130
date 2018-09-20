require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < MiniTest::Test
  def setup
    @transaction = Transaction.new(50)
  end

  def test_prompt_for_payment_sets_amount_paid
    input = StringIO.new('50\n')
    @transaction.prompt_for_payment(input: input)
    assert_equal 50, @transaction.amount_paid
  end

end


    assert_equal @transaction.amount_paid, @transaction.prompt_for_payment(input: input)
