VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_results(player, computer)
  if player == 'rock' && computer == 'scissors' ||
      player == 'paper' && computer == 'rock' ||
      player == 'scissors' && computer == 'paper'
    "You won!"
  elsif player == 'rock' && computer == 'paper' ||
      player == 'paper' && computer == 'scissors' ||
      player == 'scissors' && computer == 'rock'
    "Computer won!"
  else
    "It's a tie!"
  end
end

puts "-" * 75
puts "ROCK, PAPER, SCISSORS".center(75)
puts "-" * 75

loop do #main loop
  choice = ''
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = gets.chomp
    break if VALID_CHOICES.include?(choice)
    prompt "That's not a valid choice!"
  end

  computer_choice = VALID_CHOICES.sample
  prompt "You chose: #{choice}, the computer chose: #{computer_choice}."
  prompt display_results(choice, computer_choice)

  puts "Do you want to play again? ('Y' or 'N')"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing!"
