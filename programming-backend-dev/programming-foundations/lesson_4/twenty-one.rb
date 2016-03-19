# twenty-one.rb
require 'pry'
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
  puts card_line_border_for_hand(hand)
  puts card_line_one_for_hand(hand)
  puts card_line_two_for_hand(hand)
  puts card_line_three_for_hand(hand)
  puts card_line_border_for_hand(hand)
end

def print_first_card(hand)
  puts ".---."
  puts "|#{hand[0][0]}  |"
  puts "| #{hand[0][1]} |"
  puts "|  #{hand[0][0]}|"
  puts ".---."
end

def show_players_cards(hand)
  puts "\nPlayer:"
  print_hand(hand)
end

def show_one_card(dealer)
  puts "\nDealer:"
  print_first_card(dealer)
end

def show_all_cards(dealer)
  puts "\nDealers:"
  print_hand(dealer)
end

def hit_or_stay?
  choice = ''
  loop do
    puts "Hit or Stay?"
    choice = gets.strip.downcase
    break if choice == 'hit' || choice == 'stay'
    puts "Please choose Hit or Stay!"
  end
  choice
end

def player_finished?(hand)
  bust?(hand) || twenty_one?(hand) || total_of(hand) == 21
end

def players_turn!(deck, players_hand, dealers_hand)
  loop do
    
    system 'clear' or system 'cls'
    show_one_card(dealers_hand)
    
    show_players_cards(players_hand)
    display_total(players_hand)
    break if player_finished?(players_hand)
    hit_or_stay? == 'hit' ? deal_card(deck, players_hand) : break
  end
  system 'clear' or system 'cls'
  show_one_card(dealers_hand)
  show_players_cards(players_hand)
  display_total(players_hand)
end

def dealers_turn!(deck, players_hand, dealers_hand)
  unless bust?(players_hand) || twenty_one?(players_hand)
    loop do
      system 'clear' or system 'cls'
      show_all_cards(dealers_hand)
      show_players_cards(players_hand)
      display_total(players_hand)
      break if total_of(dealers_hand) >= 17
      deal_card(deck, dealers_hand)
      sleep 1.5
    end
  end
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
    puts "\nTwenty One!"
  elsif bust?(hand)
    puts "\nHand total: BUST!"
  else
    puts "\nHand total: #{total_of(hand)}"
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
    puts "House Wins\n"
  elsif twenty_one?(player)
    puts "You Win!\n"
  elsif total_of(player) == total_of(dealer)
    puts "Push\n"
  else
    puts "You Win!\n"
  end
end

# GAME PLAY
loop do
  players_hand = []
  dealers_hand = []
  deck = DECK
  deck.shuffle!
  initial_deal(deck, players_hand, dealers_hand)
  players_turn!(deck, players_hand, dealers_hand)
  dealers_turn!(deck, players_hand, dealers_hand)
  announce_winner(players_hand, dealers_hand)
  puts "Play Again?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
