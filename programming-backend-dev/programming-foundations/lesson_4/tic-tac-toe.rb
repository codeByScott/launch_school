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

def clear
  system "clear"
end


def joinor(array, delimeter=", ", conjunction="or")
  array[-1] = "#{conjunction} #{array.last}" if array.size > 1
  array.join(delimeter)
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
  #system "say Hello #{name}, I am happy to play Tic Tac Toe with you."
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
    prompt "Choose a square (#{joinor(empty_square?(brd))}):"
    square = gets.chomp.to_i
    break if empty_square?(brd).include?(square)
    prompt "Sorry, that isn't a valid choice!"
  end
  brd[square] = PLAYER_MARKER
end

def aggressive_ai(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  
  elsif brd.values_at(*line).count(marker) == 2
    brd.select{ |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first    
  
  else
    nil
  end
end

def defensive_ai(brd, line)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2
    brd.select{ |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end  
end

def computer_input!(brd)
  square = nil
  
  # Offense
  WINNING_COMBINATIONS.each do |line|
    square = aggressive_ai(brd, line, COMPUTER_MARKER)
    break if square
  end
  
  # defense
  if !square
    WINNING_COMBINATIONS.each do |line|
      square = aggressive_ai(brd, line, PLAYER_MARKER)
      break if square
    end
  end
    
  # other selection
  if !square
    if brd[5] == INITIAL_MARKER
      square = 5
    else
      square = empty_square?(brd).sample
    end
   end
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

def announce_round_winner(brd)
  if winner?(brd)
    #system "say #{detect_winner(board)} this time!"
    prompt "#{detect_winner(brd)} this time!"
  else
    #system "say It is a tie!"
    prompt "It's a tie!"
  end
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

def score_keeper(brd, score)
  if detect_winner(brd) == 'You beat me'
    score[:wins] += 1
  elsif detect_winner(brd) == 'I beat you'
    score[:losses] += 1
  elsif board_full?(brd)
    score[:draws] += 1
  end
end

def display_score(score)
  "Wins: #{score[:wins]} Losses: #{score[:losses]} Draws: #{score[:draws]}"
end

def display_winner(score)
  score[:wins] > score[:losses] ? "You WON the game!" : "You LOST the game!"
end

# GAME PLAY
clear
ask_name(name)
clear
welcome_message(name)
current_score = { wins: 0, losses: 0, draws: 0 }

until current_score[:wins] == 3 || current_score[:losses] == 3
  board = initialize_board
  turns(board)
  display_board(board)
  if current_score[:wins] == 3 || current_score[:losses] == 3  
    announce_round_winner(board)
  end
  
  score_keeper(board, current_score)
  prompt display_score(current_score)
end
  #system "say Thanks for playing!"
  prompt display_winner(current_score)
  prompt "Have a good day!"
