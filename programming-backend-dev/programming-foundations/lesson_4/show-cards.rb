SHOE = { h:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]},
                     s:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]}, 
                     d:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]},
                     c:{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": [1, 11]}}

deck_of_cards = [ ['2', 'h'], ['3', 'h'], ['4', 'h'], ['5', 'h'], ['6', 'h'], ['7', 'h'], ['8', 'h'], ['9', 'h'], ['10', 'h'], ['j', 'h'], ['q', 'h'], ['k', 'h'], ['a', 'h'],
                  ['2', 's'], ['3', 's'], ['4', 's'], ['5', 's'], ['6', 's'], ['7', 's'], ['8', 's'], ['9', 's'], ['10', 's'], ['j', 's'], ['q', 's'], ['k', 's'], ['a', 's'],
                  ['2', 'd'], ['3', 'd'], ['4', 'd'], ['5', 'd'], ['6', 'd'], ['7', 'd'], ['8', 'd'], ['9', 'd'], ['10', 'd'], ['j', 'd'], ['q', 'd'], ['k', 'd'], ['a', 'd'],
                  ['2', 'c'], ['3', 'c'], ['4', 'c'], ['5', 'c'], ['6', 'c'], ['7', 'c'], ['8', 'c'], ['9', 'c'], ['10', 'c'], ['j', 'c'], ['q', 'c'], ['k', 'c'], ['a', 'c']]

players_hand = []
dealers_hand = []
def deal_cards(deck, player, dealer)
  2.times do
    player << deck.pop  
    dealer << deck.pop
  end
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

deal_cards(deck_of_cards, players_hand, dealers_hand)
show_cards(players_hand, dealers_hand)
players_hand << deck_of_cards.pop
show_cards(players_hand, dealers_hand)
