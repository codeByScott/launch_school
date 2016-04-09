CARDS = [['2 of s', '2'], ['3 of s', '3'], ['4 of s', '4'], ['5 of s', '5'], ['6 of s', '6'], ['7 of s', '7'], ['8 of s', '8'], ['9 of s', '9'], ['10 of s', '10'], ['Jack of s', '10'], ['Queen of s', '10'], ['King of s', '10'], ['Ace of s', '11']]

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
GOAL = 21
DEALER_HOLD_POINT = 17

def prompt(message)
  puts "=> #{message}"
end

def introduce_game
  system 'clear' or system 'cls'
  prompt "Welcome to #{GOAL}.  The first to win five hands wins the game."
  sleep 1.5
end

def make_new_deck(deck)
  SUITS.each do |name|
    CARDS.each do |arr|
      deck.push arr.map { |str| str.sub('s', name) }
    end
  end
  deck.each { |arr| arr[1] = arr[1].to_i }
end

def shuffle_new_deck(new_deck)
  new_deck.shuffle
end

def deal_hands(deck, hand)
  2.times do
    hand[:player].unshift deck.shift
    hand[:dealer].unshift deck.shift
  end
end

def update_hands_values(hands, totals)
  totals.each_key do |k|
    totals[k] = hands[k].flatten.select { |n| n == n.to_i }
                        .inject { |sum, n| sum + n }
    hands[k].flatten.count(11).times do
      totals[k] -= 10 if totals[k] > GOAL
    end
  end
end

def hit_me(hands, turn, deck)
  hands[turn].push deck.shift
end

def busted?(totals, turn)
  if totals[turn] > GOAL
    true
  end
end

def display_status(hands, score)
  system 'clear' or system 'cls'
  prompt "Game Score: Dealer: #{score[:dealer]} // Player: #{score[:player]}"
  puts
  prompt "Current Hand."
  prompt "Dealer's Cards: showing #{hands[:dealer][0][0]} and #{hands[:dealer]
      .length - 1} hidden"
  prompt "Your Cards: #{hands[:player].flatten
      .select { |c| c != c.to_i }.join(', ')}"
  puts
end

def determine_hand_outcome(totals)
  comparison = GOAL - totals[:player] <=> GOAL - totals[:dealer]
  if totals[:player] > GOAL
    'player busts'
  elsif totals[:dealer] > GOAL
    'dealer busts'
  elsif comparison == -1
    'player'
  elsif comparison == 0
    'tie'
  else
    'dealer'
  end
end

def increment_scores(outcome, score)
  if outcome == 'player busts' || outcome == 'dealer'
    score[:dealer] += 1
  elsif outcome == 'dealer busts' || outcome == 'player'
    score[:player] += 1
  end
end

def display_hand_outcome(hands, outcome, totals)
  case outcome
  when 'player' then prompt "Congratulations, you won!!"
  when 'tie' then prompt 'Wow!  That hand was a tie.'
  when 'dealer' then prompt "I'm sorry.  The dealer won. Better luck next time."
  when 'player busts' then prompt "You went over #{GOAL}.  The dealer won."
  when 'dealer busts' then prompt "The dealer went over #{GOAL}. Victory is yours!!"
  end
  puts
  prompt "Hand Results"
  prompt "Dealer's Hand: #{hands[:dealer].flatten.select { |c| c != c.to_i }
      .join(', ')}"
  prompt "Dealer's Points: #{totals[:dealer]}\n\n"
  prompt "Player's Hand: #{hands[:player].flatten.select { |c| c != c.to_i }
      .join(', ')}"
  prompt "Player's Points: #{totals[:player]}\n\n"
  sleep 5.0
end

def display_game_outcome(score)
  system 'clear' or system 'cls'
  prompt "Final Score: Dealer: #{score[:dealer]} // Player: #{score[:player]}"
  if score[:dealer] == 5
    "I'm sorry.  The dealer won this game."
  else
    "Congratulations!  You beat the dealer!!"
  end
end

loop do
  introduce_game
  response = nil

  loop do
    scores = { dealer: 0, player: 0 }

    loop do
      deck = []
      deck_in_play = shuffle_new_deck(make_new_deck(deck))
      hands = { dealer: [], player: [] }
      hands_totals = { dealer: 0, player: 0 }
      deal_hands(deck_in_play, hands)
      display_status(hands, scores)

      loop do
        prompt "Would you like to hit or stay?"

        loop do
          response = gets.chomp
          break if response.casecmp('stay') == 0 || response.casecmp('hit') == 0
          prompt "That's not a valid game option.  Enter 'hit' or 'stay'."
        end

        break if response.casecmp('stay') == 0
        hit_me(hands, :player, deck_in_play)
        update_hands_values(hands, hands_totals)
        prompt "Your new card is: #{hands[:player][-1][0]}"
        sleep 1.0
        display_status(hands, scores)
        break if busted?(hands_totals, :player) || hands_totals[:player] == GOAL
      end

      if response == 'stay'
        prompt "OK. You chose to stay. Now it is the dealer's turn."
        sleep 1.0
      end

      loop do
        break if busted?(hands_totals, :player) || (hands_totals[:player] == GOAL)
        break if busted?(hands_totals, :dealer) || (hands_totals[:dealer] >= DEALER_HOLD_POINT)
        prompt "Dealer hits."
        sleep 1.0
        hit_me(hands, :dealer, deck_in_play)
        display_status(hands, scores)
        update_hands_values(hands, hands_totals)
      end

      if !busted?(hands_totals, :dealer) && !busted?(hands_totals, :player) && !(hands_totals[:player] == GOAL)
        prompt "Dealer stays."
        sleep 1.0
      end

      current_hand_outcome = determine_hand_outcome(hands_totals)
      display_hand_outcome(hands, current_hand_outcome, hands_totals)
      increment_scores(current_hand_outcome, scores)
      break if scores[:dealer] == 5 || scores[:player] == 5
    end

    display_game_outcome(scores)
    prompt "Would you like a rematch?"

    loop do
      response = gets.chomp
      break if response.casecmp('yes') == 0 || response.casecmp('no') == 0
      prompt "That's not an option.  Please enter 'yes' or 'no'."
    end

    break if response.casecmp('no') == 0
  end

  break if response.casecmp('no') == 0
end

prompt "Thanks for playing.  Good bye!"