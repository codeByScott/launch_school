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

# Cannot decide which to use yet
SUITS_AND_VALUES = { h:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]},
                     s:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]}, 
                     d:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]},
                     c:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]}}

deck_of_cards = [ ['2', 'h'], ['3', 'h'], ['4', 'h'], ['5', 'h'], ['6', 'h'], ['7', 'h'], ['8', 'h'], ['9', 'h'], ['10', 'h'], ['j', 'h'], ['q', 'h'], ['k', 'h'], ['a', 'h'],
                  ['2', 's'], ['3', 's'], ['4', 's'], ['5', 's'], ['6', 's'], ['7', 's'], ['8', 's'], ['9', 's'], ['10', 's'], ['j', 's'], ['q', 's'], ['k', 's'], ['a', 's'],
                  ['2', 'd'], ['3', 'd'], ['4', 'd'], ['5', 'd'], ['6', 'd'], ['7', 'd'], ['8', 'd'], ['9', 'd'], ['10', 'd'], ['j', 'd'], ['q', 'd'], ['k', 'd'], ['a', 'd'],
                  ['2', 'c'], ['3', 'c'], ['4', 'c'], ['5', 'c'], ['6', 'c'], ['7', 'c'], ['8', 'c'], ['9', 'c'], ['10', 'c'], ['j', 'c'], ['q', 'c'], ['k', 'c'], ['a', 'c']]

def shuffle!(deck)
  deck.shuffle!
end

players_hand = []
dealers_hand = []
def deal_cards(deck, hand)
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
    choice == 'hit' ? deal_cards(deck, players_hand) : break
    show_cards(players_hand, dealers_hand)
    break if bust?(players_hand)
  end
  show_cards(players_hand, dealers_hand)
end  

def total_of(hand)
  hand_total = 0
  hand.each do |card|
    hand_total += card[0].to_i
  end
  hand_total
end

def display_total(hand)
  puts "Hand total: #{total_of(hand)}"
end

def initial_deal(deck, player, dealer)
  # This is done so the player gets the 1st card from the top of the deck, 
  # the dealer gets the 2nd, and so on.  Keeping it real!
  2.times do 
    deal_cards(deck, player) 
    deal_cards(deck, dealer)
  end
end

def bust?(hand)
  total_of(hand) > 21
end

# GAME PLAY
deck = deck_of_cards
shuffle!(deck)
initial_deal(deck, players_hand, dealers_hand)
show_cards(players_hand, dealers_hand)
players_turn!(deck, players_hand, dealers_hand)
# dealer_plays
# announce_winner


