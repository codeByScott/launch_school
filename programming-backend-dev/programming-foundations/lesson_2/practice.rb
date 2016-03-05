

def score_keeper(choice, computer_choice)
  
  if choice == 'win'
    wins += 1
  elsif computer_choice == 'win'
    losses += 1
  else
    draws += 1
  end
  puts "Wins: #{wins} Losses: #{losses} Draws: #{draws}"
end

wins = losses = draws = 0
score_keeper('win', 'lose')
score_keeper('lose', 'win')
score_keeper('', '')