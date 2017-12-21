require 'pry'

ScoreKeeper = Struct.new(:human, :computer, :draw)

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]] # diagonals

  attr_accessor :squares

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts "-------------"
    puts "| #{squares[1]} | #{squares[2]} | #{squares[3]} |"
    puts "|---+---+---|"
    puts "| #{squares[4]} | #{squares[5]} | #{squares[6]} |"
    puts "|---+---+---|"
    puts "| #{squares[7]} | #{squares[8]} | #{squares[9]} |"
    puts "-------------"
  end

  def []=(num, marker)
    squares[num].marker = marker
  end

  def unmarked_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def to_s
    marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  SCORE_TO_WIN = 3

  attr_reader :board, :human, :computer, :score

  def initialize
    @score = ScoreKeeper.new(0, 0, 0)
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear_display
    display_welcome_message
    display_board

    loop do
      loop do
        current_player_moves
        break if board.someone_won? || board.full?

        set_display if human_turn?
      end

      set_display

      display_result
      update_score
      display_score
      if game_over?
        reset_score
        break unless play_again?
     end
      reset
    end

    display_goodbye_message
  end

  private

  def reset_score
    score.members.each { |member| score[member] = 0 }
  end

  def game_over?
    score[:human] == SCORE_TO_WIN || score[:computer] == SCORE_TO_WIN
  end

  def update_score
    case board.winning_marker
    when human.marker
      score.human += 1
    when computer.marker
      score.computer += 1
    else
      score.draw += 1
    end
  end

  def display_score
    puts "Human: #{score.human}"
    puts "Computer: #{score.computer}"
    puts "Draws: #{score.draw}"
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    puts "Let's play again!"
    sleep 1.25
    set_display
  end

  def set_display
    clear_display
    display_board
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n):"
      answer = gets.chomp.downcase
      break if %w[y yes n no].include? answer
      puts "Sorry, you must choose y or n."
    end

    %w[y yes].include? answer
  end

  def human_moves
    puts "Choose an available square: #{joinor(board.unmarked_keys)}"
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include? square
      puts "Sorry, you must choose an available square."
    end

    board[square] = human.marker
  end

  def joinor(array, delimeter= ', ', conjuction= 'or')
    case array.size
    when 0 then ''
    when 1 then array.first
    when 2 then array.join(" #{conjuction} ")
    else
      array[-1] = "#{conjuction} #{array.last}"
      array.join(delimeter)
    end
  end

  def computer_moves
    # in order, do the following:
    # check each line for an opportunity to win.
    # check each line for an opportunity to block.
    # pick square 5 if available.
    # pick a random square.

    square = nil
    
    Board::WINNING_LINES.each do |line|
      square = find_winning_opportunity(line)
      break if square
    end

    if !square
      Board::WINNING_LINES.each do |line|
        square = find_blocking_opportunity(line)
        break if square
      end
    end

    if !square && board.squares[5].unmarked?
      square = 5
    elsif !square && board.squares[5].marked?
      square = board.unmarked_keys.sample
    end

    board[square] = COMPUTER_MARKER
  end

  # right now, it is going through at risk squares, line by line. It will return the first at risk square.
  # The problem is that it checks in order. [1, 2, 3], [4, 5, 6], [7, 8, 9], etc.
  # It will ask "are there two_computer_markers for this line?"
  # "Are there two_human_markers for this line?"
  # It should instead check the entire board for an opportunity to win. Then check for opportunities to block.

  def find_winning_opportunity(line)
    if two_computer_markers?(line)
      choose_empty_square(line)
    else
      nil
    end
  end

  def find_blocking_opportunity(line)
    if two_human_markers?(line)
      choose_empty_square(line)
    else
      nil
    end
  end

  def two_computer_markers?(line)
    line.count { |square| board.squares[square].marker == COMPUTER_MARKER } == 2
  end

  def two_human_markers?(line)
    line.count { |square| board.squares[square].marker == HUMAN_MARKER } == 2
  end

  def choose_empty_square(line)
    line.select { |square| board.squares[square].marker == " " }.first
  end

  def display_board
    board.draw
  end

  def display_result
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a draw!"
    end
  end

  def clear_display
    system('clear') || system('clr')
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe."
    puts "You're #{human.marker}. The computer is #{computer.marker}."
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe."
  end
end

game = TTTGame.new
game.play
