# tic-tac-toe.rb

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                        [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
                        [1, 5, 9], [3, 5, 7]].freeze     # diagonal

def prompt(msg)
  puts "=> #{msg}"
end

name = ' '
def ask_name(name)
  puts "How would you like me to address you?"
  name << gets.chomp
end

def welcome_message(name)
  puts
  puts "*" * 50
  puts "Tic Tac Toe".ljust(25) + "A Game by codeByScott".rjust(25)
  puts "*" * 50
  system "say Hello #{name}, I am happy to play Tic Tac Toe with you."
  prompt "You are #{PLAYER_MARKER}.  I am #{COMPUTER_MARKER}."
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def display_board(brd)
  puts " #{brd[1]} | #{brd[2]} | #{brd[3]} "
  puts "-----------"
  puts " #{brd[4]} | #{brd[5]} | #{brd[6]} "
  puts "-----------"
  puts " #{brd[7]} | #{brd[8]} | #{brd[9]} "
  puts
end

def empty_square?(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def user_input!(brd)
  square = ''
  loop do
    prompt "Choose a square (1-9):"
    square = gets.chomp.to_i
    break if empty_square?(brd).include?(square)
    prompt "Sorry, that isn't a valid choice!"
  end
  brd[square] = PLAYER_MARKER
end

def computer_input!(brd)
  square = empty_square?(brd).sample
  brd[square] = COMPUTER_MARKER
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_COMBINATIONS.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'You beat me'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'I beat you'
    end
  end
  nil
end

def board_full?(brd)
  empty_square?(brd).empty?
end

def play_again?
  system "say Would you like to play again?"
  prompt "Play again? ('Y' or 'N')"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def turns(brd)
  loop do
    display_board(brd)

    user_input!(brd)
    break if winner?(brd) || board_full?(brd)

    computer_input!(brd)
    break if winner?(brd) || board_full?(brd)
  end
end

def play
  loop do
    board = initialize_board
    turns(board)
    display_board(board)

    if winner?(board)
      system "say #{detect_winner(board)} this time!"
      prompt "#{detect_winner(board)} this time!"
    else
      system "say It is a tie!"
      prompt "It's a tie!"
    end
    break unless play_again?
  end
  system "say Thanks for playing!"
  prompt "Have a good day!"
end

system "clear"
ask_name(name)
system 'clear'
welcome_message(name)
play
