require 'minitest/autorun'
require_relative 'cash_register'

class CashRegisterTest < MiniTest::Test
  def setup
    @register = CashRegister.new(100)
  end

  def test_setting_initial_total_money
    assert_equal(@register.total_money, 100)
  end
end