# tic-tac-toe.rb

INITIAL_TOKEN = ' '.freeze
PLAYER_TOKEN = "X".freeze
COMPUTER_TOKEN = "O".freeze
WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                        [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
                        [1, 5, 9], [3, 5, 7]].freeze     # diagonal

# Helper Methods
def joinor(array, delimeter=", ", conjunction="or")
  array[-1] = "#{conjunction} #{array.last}" if array.size > 1
  array.join(delimeter)
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_TOKEN }
  new_board
end

def user_place_token!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_square?(brd))}):"
    square = gets.chomp.to_i
    break if empty_square?(brd).include?(square)
    prompt "Sorry, that isn't a valid choice!"
  end
  brd[square] = PLAYER_TOKEN
end

def place_token!(brd)
  loop do
    display_board(brd)
    if current_player?(brd) == 'human_player'
      user_place_token!(brd)
    else
      computer_place_token!(brd)
    end
    break if winner?(brd) || board_full?(brd)
  end
end

# Displays and Announcements
def prompt(msg)
  puts "=> #{msg}"
end

def clear
  system "clear"
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
  prompt "You are #{PLAYER_TOKEN}.  I am #{COMPUTER_TOKEN}."
end

def display_board(brd)
  puts " #{brd[1]} | #{brd[2]} | #{brd[3]} "
  puts "-----------"
  puts " #{brd[4]} | #{brd[5]} | #{brd[6]} "
  puts "-----------"
  puts " #{brd[7]} | #{brd[8]} | #{brd[9]} "
  puts
end

def display_score(score)
  "Wins: #{score[:wins]} Losses: #{score[:losses]} Draws: #{score[:draws]}"
end

def detect_winner(brd)
  WINNING_COMBINATIONS.each do |line|
    if brd.values_at(*line).count(PLAYER_TOKEN) == 3
      return 'You beat me'
    elsif brd.values_at(*line).count(COMPUTER_TOKEN) == 3
      return 'I beat you'
    end
  end
  nil
end

def display_winner(score)
  score[:wins] > score[:losses] ? "You WON the game!" : "You LOST the game!"
end

def announce_round_winner(brd)
  if winner?(brd)
    system "say #{detect_winner(brd)} this time!"
    prompt "#{detect_winner(brd)} this time!"
  else
    system "say It is a tie!"
    prompt "It's a tie!"
  end
end

def score_keeper(brd, score)
  if detect_winner(brd) == 'You beat me'
    score[:wins] += 1
  elsif detect_winner(brd) == 'I beat you'
    score[:losses] += 1
  elsif board_full?(brd)
    score[:draws] += 1
  end
end

# Game Status?
def game_over?(current_score)
  current_score[:wins] == 2 || current_score[:losses] == 2
end

def round_over?(brd)
  winner?(brd) || board_full?(brd)
end

def play_again?
  system "say Would you like to play again?"
  prompt "Play again? ('Y' or 'N')"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def current_player?(brd)
  brd.values.count(" ").odd? ? 'human_player' : 'cpu_player'
end

def winner?(brd)
  !!detect_winner(brd)
end

def board_full?(brd)
  empty_square?(brd).empty?
end

def empty_square?(brd)
  brd.keys.select { |num| brd[num] == INITIAL_TOKEN }
end

# CPU AI
def computer_place_token!(brd)
  square = nil
  # Offense
  WINNING_COMBINATIONS.each do |line|
    square = aggressive_ai_move(brd, line, COMPUTER_TOKEN)
    break if square
  end
  # defense
  if !square
    WINNING_COMBINATIONS.each do |line|
      square = aggressive_ai_move(brd, line, PLAYER_TOKEN)
      break if square
    end
  end
  # other strategy
  if !square
    square = if brd[5] == INITIAL_TOKEN
               5
             else
               empty_square?(brd).sample
             end
  end
  brd[square] = COMPUTER_TOKEN
end

def aggressive_ai_move(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_TOKEN }.keys.first
  elsif brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_TOKEN }.keys.first
  end
end

def defensive_ai_move(brd, line)
  if brd.values_at(*line).count(PLAYER_TOKEN) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_TOKEN }.keys.first
  end
end

# Game Play
clear
ask_name(name)
clear
welcome_message(name)

current_score = { wins: 0, losses: 0, draws: 0 }

until game_over?(current_score)
  board = initialize_board
  place_token!(board)
  display_board(board)
  score_keeper(board, current_score)
  announce_round_winner(board) if round_over?(board) && !game_over?(current_score)
  prompt display_score(current_score) if round_over?(board) && !game_over?(current_score)
end
system "say Thanks for playing!"
prompt display_winner(current_score)
prompt "FINAL SCORE => #{display_score(current_score)}"
