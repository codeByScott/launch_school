# calculator.rb

# ask the user for their preferred language
# Welcome the user
# ask for the users name
# greet the user by name
# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result
# ask the user if they would like to calculate again
# Say goodbye to user when they are finished

require 'yaml'
MESSAGES = YAML.load_file("calculator_messages.yml")

def messages(message, lang='en')
  MESSAGES[lang][message]
end

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

prompt("Preferred Language? (¿Idioma preferido?): \n1) english\n2) espanol")
lang = ''
  loop do
    lang = gets.chomp
    if %w(1 2).include?(lang)
      if lang == '1'
        lang = 'en'
      else
        lang = 'es'
      end
      break
    else
      prompt("1) for english 2) para el español")
    end
  end


prompt(messages('welcome', lang))

name = ''
loop do
  name = gets.chomp
  
  if name.empty?
    prompt(messages('valid_name', lang))
  else
    break
  end
end

prompt(messages('greet', lang) + " #{name}")

loop do # main loop
  
  number1 = ''
  loop do
    prompt(messages('request_number1', lang))
    number1 = Float(gets) rescue false
    if number1
      break
    else
      prompt(messages('invalid_number', lang))
    end
  end
  
  number2 = false
  while !number2
    prompt(messages('request_number2', lang))
    number2 = Float(gets) rescue false
    prompt(messages('invalid_number', lang)) if !number2
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
      prompt(messages('valid_operator', lang))
    end
  end
  
  prompt("#{operating_to_msg(operator)}" + messages('operating', lang))
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

  prompt(messages('results', lang) + "#{result.to_f}")
  prompt(messages('continue?', lang))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages('goodbye', lang) + " #{name}. " + messages('goodbye2', lang))