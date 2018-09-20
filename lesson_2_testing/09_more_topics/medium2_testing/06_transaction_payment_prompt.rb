=begin
Test Prompt For Payment Method- Transaction

Write a test that verifies that Transaction#prompt_for_payment sets
the amount_paid correctly. We've changed the transaction class a bit
to make testing this a bit easier. The Transaction#prompt_for_payment
now reads as:

def prompt_for_payment(input: $stdin) # We've set a default parameter
for stdin
  loop do
    puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f # notice that we call gets on
                                         # that parameter
    break if valid_payment? && sufficient_payment?
    puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

=end
