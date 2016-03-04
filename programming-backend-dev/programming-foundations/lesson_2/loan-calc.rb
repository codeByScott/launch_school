# loan-calc.rb

# - Get the loan amount
# - Get the annual percentage rate
# - get the loan duration
# display monthly loan amount
# display total loan amount after interest


loan_amt = ''
loop do
  print "Enter loan amount: "
  loan_amt = Float(gets) rescue false
  if loan_amt
    break
  else
    puts "Please enter a proper loan amount (numbers only)"
  end
end

monthly_rate = ''
loop do
  print "Enter Annual Percentage Rate (APR) (i.e. 7.25): "
  annual_rate = Float(gets) rescue false
  if annual_rate and annual_rate.to_i > 0
    monthly_rate = (annual_rate / 100) / 12
    break
  else
    puts "Oops...that doesn't seem to be valid!"
  end
end

loan_length = ''
loop do
  print "Enter loan duration (in months): "
  loan_length = Integer(gets) rescue false
  if loan_length and loan_length > 0
    break
  else
    puts "Oops...that doesn't seem to be valid!"
  end
end

monthly_amount = (loan_amt * (1 + monthly_rate)**loan_length * monthly_rate) / ((1 + monthly_rate)**loan_length - 1)

puts "Your monthly payment is: #{monthly_amount.round(2)}"



