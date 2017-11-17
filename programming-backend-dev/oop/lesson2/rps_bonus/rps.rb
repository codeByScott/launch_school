# the user makes a choice
# the computer makes a choice
# the winner is displayed

# Rock, Paper, Scissors is a two-player game where each player chooses
# one of three possible moves: rock, paper, or scissors. The chosen moves
# will then be compared to see who wins, according to the following rules:
#
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
#
# If the players chose the same move, then it's a tie.

# Nouns: player, move, rule
# Verbs: choose, compare

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end

  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry must enter a value."
    end
    self.name = n
  end
end

class Computer < Player
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end

  def set_name
    self.name = ['C3PO', 'D.A.R.Y.L.', 'HAL', 'Number 5', 'Wall-e'].sample
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors'].freeze

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    value
  end
end

class Score
  attr_accessor :wins, :losses, :draws

  def initialize
    @wins = 0
    @losses = 0
    @draws = 0
  end
end

class RPSGame
  BEST_OF = 2

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      display_score(human)
      display_score(computer)
      if game_over?
        reset_score
        break unless play_again?
      end
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing, goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def human_won?
    human.move > computer.move
  end

  def computer_won?
    computer.move > human.move
  end

  def adjust_score_for_draw
    human.score.draws += 1
    computer.score.draws += 1
  end

  def adjust_score_for_human_win
    human.score.wins += 1
    computer.score.losses += 1
  end

  def adjust_score_for_computer_win
    computer.score.wins += 1
    human.score.losses += 1
  end

  def update_score
    if human_won?
      adjust_score_for_human_win
    elsif computer_won?
      adjust_score_for_computer_win
    else
      adjust_score_for_draw
    end
  end

  def reset_score
    human.score.wins = 0
    human.score.losses = 0
    human.score.draws = 0
    computer.score.wins = 0
    computer.score.losses = 0
    computer.score.draws = 0
  end

  def display_winner
    if human_won?
      puts "#{human.name} won!"
    elsif computer_won?
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score(player)
    puts truncate(player.name, 15).to_s.ljust(20) +
         "Wins: #{player.score.wins}".ljust(20) +
         "Losses: #{player.score.losses}".center(20) +
         "Draws: #{player.score.draws}".rjust(20)
  end

  def truncate(string, length)
    if string.size > length
      truncated = string.split(//)
      loop do
        truncated.pop
        break if truncated.size == length
      end
      truncated.join + "..."
    else
      string
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def game_over?
    (human.score.wins == BEST_OF) || (computer.score.wins == BEST_OF)
  end
end

RPSGame.new.play
