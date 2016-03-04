# loan-calc.rb

# - Get the loan amount
# - Get the annual percentage rate
# - get the loan duration
# display monthly loan amount
# display total loan amount after interest

print "Enter loan amount: "
loan_amt = gets.chomp.to_f

print "Enter Annual Percentage Rate (APR) (i.e. 7.25): "
annual_rate = gets.chomp.to_f
monthly_rate = (annual_rate / 100) / 12

print "Enter the loan duration (in months): "
loan_length = gets.chomp.to_f

monthly_amount = (loan_amt * (1 + monthly_rate)**loan_length * monthly_rate) / ((1 + monthly_rate)**loan_length - 1)

puts "Your monthly payment is: #{monthly_amount.round(2)}"



