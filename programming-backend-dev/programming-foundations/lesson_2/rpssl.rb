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
    "You won the round!"
  elsif win_round?(computer, player)
    "You lost this round!"
  else
    "It's a tie!"
  end
end
current_score = { wins: 0, losses: 0, draws: 0 }

def score_keeper(score, player, computer)
  if win_round?(player, computer)
    score[:wins] += 1
  elsif win_round?(computer, player)
    score[:losses] += 1
  else
    score[:draws] += 1
  end
end

def display_score(score)
 "Wins: #{score[:wins]} Losses: #{score[:losses]} Draws: #{score[:draws]}"
end

def display_winner(score)
  score[:wins] == 5 ? "You WON the game!" : "You LOST the game"
end

puts
puts "-" * 75
puts "ROCK, PAPER, SCISSORS, SPOCK, LIZARD".ljust(50) + "Created by CodeByScott".rjust(25)
puts "-" * 75
puts
prompt "First to five wins"

until current_score[:wins] == 5 || current_score[:losses] == 5 do # main loop

  user_choice = ''
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    user_choice = gets.chomp
    break if VALID_CHOICES.include?(user_choice)
    prompt "That's not a valid choice!"
  end

  computer_choice = VALID_CHOICES.sample
  
  prompt "#{user_choice.capitalize} VS #{computer_choice.capitalize}: #{display_results(user_choice, computer_choice)}"
  score_keeper(current_score, user_choice, computer_choice)
  prompt display_score(current_score)
  
end
prompt display_winner(current_score)
prompt "Thank you for playing RPSSL!"
