# twenty-one.rb

# * identified bugs *
# shows dealers cards before the player is finished (need a flag)
# does not end game when player gets Twenty One (Black Jack)
# need to use 0 for 10 so the cards do not get skewed

SUITS = %w(c d h s).freeze
RANKS = %w(2 3 4 5 6 7 8 9 0 j q k a).freeze
DECK = RANKS.product(SUITS)

def deal_card(deck, hand)
  hand << deck.pop
end

def card_line_border_for_hand(hand)
  line = ""

  hand.each do
    line << " " unless line == "" # add a separator
    line << ".---." # top/bottom border design
  end

  line
end

def card_line_one_for_hand(hand)
  line = ""

  hand.each do |card|
    line << " " unless line == "" # add a separator
    line << "|#{card[0]}  |" # card line design
  end

  line
end

def card_line_two_for_hand(hand)
  line = ""

  hand.each do |card|
    line << " " unless line == "" # add a separator
    line << "| #{card[1]} |" # card line design
  end

  line
end

def card_line_three_for_hand(hand)
  line = ""

  hand.each do |card|
    line << " " unless line == "" # add a separator
    line << "|  #{card[0]}|" # card line design
  end

  line
end

def print_hand(hand)
  puts
  puts card_line_border_for_hand(hand)
  puts card_line_one_for_hand(hand)
  puts card_line_two_for_hand(hand)
  puts card_line_three_for_hand(hand)
  puts card_line_border_for_hand(hand)
  puts
end

def show_cards(players_hand, dealers_hand)
  puts
  puts "Dealer shows:"
  if # player has finished
    print_hand(dealers_hand)
  else
    puts ".---."
    puts "|#{dealers_hand[0][0]}  |"
    puts "| #{dealers_hand[0][1]} |"
    puts "|  #{dealers_hand[0][0]}|"
    puts ".---."
  end
  puts "Players cards:"
  print_hand(players_hand)
end

def players_turn!(deck, players_hand, dealers_hand)
  choice = nil
  loop do
    display_total(players_hand)
    puts "Hit or Stay? ('h' or 's'):"
    choice = gets.strip
    choice == 'h' ? deal_card(deck, players_hand) : break
    show_cards(players_hand, dealers_hand)
    break if bust?(players_hand) || twenty_one?(players_hand)
  end
  choice
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
    elsif value.to_i == 0 # 10, J, Q, K
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
  elsif total_of(player) == total_of(dealer)
    puts "Push"
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
show_cards(players_hand, dealers_hand)
players_turn!(deck, players_hand, dealers_hand)
dealers_turn!(deck, players_hand, dealers_hand)
announce_winner(players_hand, dealers_hand)
