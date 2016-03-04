# calculator.rb

# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result
require 'yaml'
MESSAGES = YAML.load_file("calculator_messages.yml")

def prompt(msg)
  puts("=> #{msg}")
end

def operating_to_msg(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp
  
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt(MESSAGES['greet'] + " #{name}")

loop do # main loop
  
  number1 = ''
  loop do
    prompt(MESSAGES['request_number1'])
    number1 = Float(gets) rescue false
    if number1
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end
  
  number2 = false
  while !number2
    prompt(MESSAGES['request_number2'])
    number2 = Float(gets) rescue false
    prompt(MESSAGES['invalid_number']) if !number2
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
MSG
  
  prompt(operator_prompt)
  
  operator = ''
  loop do
    operator = gets.chomp
    
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operator'])
    end
  end
  
  prompt("#{operating_to_msg(operator)}" + MESSAGES['operating'])
  sleep 1
  
  result = case operator
    when '1'
      result = number1.to_f + number2.to_f
    when '2'
      result = number1.to_f - number2.to_f
    when '3'
      result = number1.to_f * number2.to_f
    when '4'
      result = number1.to_f / number2.to_f
  end

  prompt(MESSAGES['results'] + "#{result.to_f().round(2)}")
  prompt(MESSAGES['continue?'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'] + " #{name}. " + MESSAGES['goodbye2'])