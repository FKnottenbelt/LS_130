=begin
Challenge: write a method that changes dates in the format
2016-06-17 to the format 17.06.2016. You must use a regular
expression and should use methods described in this section.

Example:

Ruby

p format_date('2016-06-17') == '17.06.2016'
p format_date('2016/06/17') == '2016/06/17' (no change)

=end





=begin
if date has - then
split the date on the -
reverse and join with dot
=end

def format_date(date)
  return date unless !!date.match(/[\-]+/)
  date.split(/\-/).reverse.join(".")
end

p format_date('2016-06-17') == '17.06.2016'
p format_date('2016/06/17') == '2016/06/17' #(no change)



# ls solution
def format_date(original_date)
  original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
end

# We use three capture groups here to capture the year, month,
# and date, then use them in the replacement string in reverse
# order, this time separated by periods instead of hyphens.