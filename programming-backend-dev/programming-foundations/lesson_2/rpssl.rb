# keep score
# whoever reaches five points first wins

VALID_CHOICES = %w(rock paper scissors spock lizard).freeze

def prompt(message)
  puts "=> #{message}"
end

def win_round?(first, second)
  first == 'rock'     && second == 'scissors' ||
  first == 'rock'     && second == 'lizard'   ||
  first == 'paper'    && second == 'rock'     ||
  first == 'paper'    && second == 'spock'    ||
  first == 'scissors' && second == 'paper'    ||
  first == 'scissors' && second == 'lizard'   ||
  first == 'spock'    && second == 'scissors' ||
  first == 'spock'    && second == 'rock'     ||
  first == 'lizard'   && second == 'spock'    ||
  first == 'lizard'   && second == 'paper'
end

def display_results(player, computer)
  if win_round?(player, computer)
    "You won!"
  elsif win_round?(computer, player)
    "Computer won!"
  else
    "It's a tie!"
  end
end

$wins = $losses = $draws = 0
def score_keeper(player, computer)
  
  if win_round?(player, computer)
    $wins += 1
  elsif win_round?(computer, player)
    $losses += 1
  else
    $draws += 1
  end
  "Wins: #{$wins} Losses: #{$losses} Draws: #{$draws}"
end

puts
puts "-" * 75
puts "ROCK, PAPER, SCISSORS, SPOCK, LIZARD".ljust(50) + "Created by CodeByScott".rjust(25)
puts "-" * 75

3.times do # main loop

  choice = ''
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    choice = gets.chomp
    break if VALID_CHOICES.include?(choice)
    prompt "That's not a valid choice!"
  end

  computer_choice = VALID_CHOICES.sample
  
  prompt "#{choice.capitalize} VS #{computer_choice.capitalize}: #{display_results(choice, computer_choice)}"
  prompt score_keeper(choice, computer_choice)
  
end

prompt "Thank you for playing RPSSL!"
