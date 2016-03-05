VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  puts "=> #{message}"
end

def display_results(player, computer)
  if player == 'rock' && computer == 'scissors' ||
      player == 'paper' && computer == 'rock' ||
      player == 'scissors' && computer == 'paper'
    prompt "You won!"
  elsif player == 'rock' && computer == 'paper' ||
      player == 'paper' && computer == 'scissors' ||
      player == 'scissors' && computer == 'rock'
    prompt "Computer won!"
  else
    prompt "It's a tie!"
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
  puts "You chose: #{choice}, the computer chose: #{computer_choice}."
  display_results(choice, computer_choice)

  puts "Do you want to play again? ('Y' or 'N')"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts "Thank you for playing!"
