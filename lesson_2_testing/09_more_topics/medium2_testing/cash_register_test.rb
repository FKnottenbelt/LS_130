require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(100)
    @transaction = Transaction.new(50)
  end

  def test_setting_initial_total_money
    @register = CashRegister.new(100)
    assert_equal(@register.total_money, 100)
  end

  def test_accept_money
    @transaction.amount_paid = 20
    assert_equal(120, @register.accept_money(@transaction))
  end

  def test_change
    @transaction.amount_paid = 55
    assert_equal(5, @register.change(@transaction))
  end
end



# ls solution

class CashRegisterTestLS < Minitest::Test

  # why so complicated?
  # the difference seems to be whether you test the inside of the procedure vs
  # the 'outside'? Why does LS choose inside?
  def test_accept_mon_ls
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end
end
