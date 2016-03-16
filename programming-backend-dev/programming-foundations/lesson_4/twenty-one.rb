=begin
1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.
=end
SUITS = %w(c d h s).freeze
RANKS = %w(2 3 4 5 6 7 8 9 10 j q k a).freeze
DECK = RANKS.product(SUITS)

def deal_card(deck, hand)
  hand << deck.pop
end

def show_initial_cards(players_hand, dealers_hand)
  puts "Dealer shows:"
  puts ".---."
  puts "|#{dealers_hand[0][0]}  |"
  puts "| #{dealers_hand[0][1]} |"
  puts "|  #{dealers_hand[0][0]}|"
  puts ".---."
  puts
  puts "Players cards:"
  players_hand.each do |card|
    puts ".---. "
    puts "|#{card[0]}  | "
    puts "| #{card[1]} | "
    puts "|  #{card[0]}| "
    puts ".---. "
    puts
  end
end

# Had to separate initial_cards from show_cards, because I couldn't think of an easy way to only show the first dealer card.
def show_cards(players_hand, dealers_hand)
  puts "Dealers cards:"
  dealers_hand.each do |card|
    puts ".---. "
    puts "|#{card[0]}  | "
    puts "| #{card[1]} | "
    puts "|  #{card[0]}| "
    puts ".---. "
    puts
  end
  puts "Players cards:"
  players_hand.each do |card|
    puts ".---. "
    puts "|#{card[0]}  | "
    puts "| #{card[1]} | "
    puts "|  #{card[0]}| "
    puts ".---. "
    puts
  end
end

def players_turn!(deck, players_hand, dealers_hand)
  choice = nil
  loop do
    display_total(players_hand)
    puts "Hit or Stay? ('h' or 's'):"
      choice = gets.strip
      choice == 'h' ? deal_card(deck, players_hand) : break
      show_initial_cards(players_hand, dealers_hand)
    break if bust?(players_hand) || twenty_one?(players_hand)
  end
  show_initial_cards(players_hand, dealers_hand)
  display_total(players_hand)
end

def dealers_turn!(deck, players_hand, dealers_hand)
  unless bust?(players_hand) || twenty_one?(players_hand)
    loop do
      break if total_of(dealers_hand) >= 17
      deal_card(deck, dealers_hand)
    end
  end
  show_cards(players_hand, dealers_hand)
end

def total_of(hand)
  values = hand.map { |card| card[0] }
  sum = 0
  
  values.each do |value|
    if value == "a"
      sum += 11
    elsif value.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end
  
  # correcting for Aces
  values.select { |value| value == "a" }.count.times do
    sum -= 10 if sum > 21
  end
  
  sum
end

def display_total(hand)
  if twenty_one?(hand)
    puts "Twenty One!"
  elsif bust?(hand)
    puts "Hand total: BUST!"
  else
    puts "Hand total: #{total_of(hand)}"
  end
end

def initial_deal(deck, player, dealer)
  # This is done so the player gets the 1st card from the top of the deck,
  # the dealer gets the 2nd, and so on.  Keeping it real!
  2.times do
    deal_card(deck, player)
    deal_card(deck, dealer)
  end
end

def bust?(hand)
  total_of(hand) > 21
end

def twenty_one?(hand)
  hand.length == 2 && total_of(hand) == 21
end

def announce_winner(player, dealer)
  if bust?(player) || !bust?(dealer) && (total_of(dealer) > total_of(player))
    puts "House Wins"
  elsif twenty_one?(player)
    puts "You Win!"
  else
    puts "You Win!"
  end
end

# GAME PLAY
players_hand = []
dealers_hand = []
deck = DECK
deck.shuffle!
initial_deal(deck, players_hand, dealers_hand)
show_initial_cards(players_hand, dealers_hand)
players_turn!(deck, players_hand, dealers_hand)
dealers_turn!(deck, players_hand, dealers_hand)
announce_winner(players_hand, dealers_hand)
