=begin
Write a minitest assertion that will fail unless employee.hire raises
a NoExperienceError exception.
=end

require 'minitest/autorun'
class NoExperienceError < StandardError ; end

class EmployeeDummy
  def hire
    raise NoExperienceError
  end
end


class MyTest < MiniTest::Test
  def setup
    @employee = EmployeeDummy.new
  end

  def test_emplyee_hire_raises_exception
    assert_raises(NoExperienceError){@employee.hire}
  end
end
