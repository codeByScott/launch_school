# loan-calc.rb

# - Get the loan amount
# - Get the annual percentage rate
# - get the loan duration
# - display monthly loan amount

def prompt(message)
  print "=> #{message}"
end

puts 
puts "-" * 50
puts "MORTGAGE CALCULATOR".center(50)
puts "-" * 50


loop do # main loop
  puts
  loan_amt = ''
  loop do
    prompt "Enter loan amount: "
    loan_amt = Float(gets) rescue false
    if loan_amt and loan_amt.to_i > 0
      break
    else
      prompt "Oops...make sure it is a number greater than 0.\n"
    end
  end

  monthly_rate = ''
  loop do
    prompt "Enter Annual Percentage Rate (APR) (i.e. 7.25): "
    annual_rate = Float(gets) rescue false
    if annual_rate and annual_rate.to_i > 0
      monthly_rate = (annual_rate / 100) / 12
      break
    else
      prompt "Oops...that doesn't seem to be valid!\n"
    end
  end

  loan_length = ''
  loop do
    prompt "Enter loan duration (in months): "
    loan_length = Integer(gets) rescue false
    if loan_length and loan_length > 0
      break
    else
      prompt "Oops...that doesn't seem to be valid!\n"
    end
  end

  monthly_amount = (loan_amt * (1 + monthly_rate)**loan_length * monthly_rate) / ((1 + monthly_rate)**loan_length - 1)

  prompt "Your monthly payment is: $#{format('%02.2f', monthly_amount)}\n"
  prompt "Would you like to make another calculation? ('Y' or 'N'): "
  again = gets.chomp
  break unless again.downcase.start_with?('y')
end


