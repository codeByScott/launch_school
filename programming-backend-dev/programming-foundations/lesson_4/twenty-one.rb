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

deck = [['2', 'h'], ['3', 'h'], ['4', 'h'], ['5', 'h'], ['6', 'h'], ['7', 'h'], ['8', 'h'], ['9', 'h'], ['10', 'h'], ['j', 'h'], ['q', 'h'], ['k', 'h'], ['a', 'h'],
        ['2', 's'], ['3', 's'], ['4', 's'], ['5', 's'], ['6', 's'], ['7', 's'], ['8', 's'], ['9', 's'], ['10', 's'], ['j', 's'], ['q', 's'], ['k', 's'], ['a', 's'],
        ['2', 'd'], ['3', 'd'], ['4', 'd'], ['5', 'd'], ['6', 'd'], ['7', 'd'], ['8', 'd'], ['9', 'd'], ['10', 'd'], ['j', 'd'], ['q', 'd'], ['k', 'd'], ['a', 'd'],
        ['2', 'c'], ['3', 'c'], ['4', 'c'], ['5', 'c'], ['6', 'c'], ['7', 'c'], ['8', 'c'], ['9', 'c'], ['10', 'c'], ['j', 'c'], ['q', 'c'], ['k', 'c'], ['a', 'c']]

def shuffle!(deck)
  deck.shuffle!
end

players_hand = []
dealers_hand = []
def deal_card(deck, hand)
  hand << deck.pop
end

def show_cards(players_hand, dealers_hand)
  puts "Dealer shows:"
  puts
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

def players_turn!(deck, players_hand, dealers_hand)
  choice = nil
  loop do
    display_total(players_hand)
    puts "Hit or Stay?:"
    choice = gets.strip
    choice == 'h' ? deal_card(deck, players_hand) : break
    show_cards(players_hand, dealers_hand)
    break if bust?(players_hand) || twenty_one?(players_hand)
  end
  show_cards(players_hand, dealers_hand)
  display_total(players_hand)
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
  total_of(hand) == 21
end

# GAME PLAY
shuffle!(deck)
initial_deal(deck, players_hand, dealers_hand)
show_cards(players_hand, dealers_hand)
players_turn!(deck, players_hand, dealers_hand)
# dealer_plays
# announce_winner
