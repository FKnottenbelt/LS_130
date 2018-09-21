=begin

Alter Prompt For Payment Method - Transaction

You may have noticed something when running the test for the previous
exercise. And that is that our minitest output wasn't that clean. We
have some residual output from the Transaction#prompt_for_payment method.

Run options: --seed 52842

# Running:

You owe $30.
How much are you paying?
.

Finished in 0.001783s, 560.7402 runs/s, 560.7402 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

Transaction#prompt_for_payment has a call to Kernel#puts and that output is showing up when we run our test. Your task for this exercise is to make it so that we have "clean" output when running this test. We want to see something like this:

Run options: --seed 4957

# Running:

.

Finished in 0.000919s, 1087.9984 runs/s, 1087.9984 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips


=end



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