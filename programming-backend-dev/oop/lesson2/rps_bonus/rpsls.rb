ScoreKeeper = Struct.new(:wins, :losses, :draws)
Logger = Struct.new(:human_moves, :computer_moves, :results)

module Strategies
  def first_round?
    move_history.computer_moves.empty?
  end

  def opponents_last_move
    move_history.human_moves.last
  end

  def beat_opponents_last_move
    opponents_last_move = move_history.human_moves.last

    move_that_beats = {
      rock: 'paper',
      paper: 'scissors',
      scissors: 'spock',
      lizard: 'rock',
      spock: 'lizard'
    }

    move_that_beats[opponents_last_move.to_sym]
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize(move_history)
    set_name
    @move_history = move_history
    @score = ScoreKeeper.new(0, 0, 0) # sets wins, losses, draws to zero
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice).value
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
  include Strategies

  def choose
    if first_round?
      self.move = Move.new("scissors").value
    else
      self.move = Move.new(beat_opponents_last_move).value
    end
  end

  def set_name
    self.name = ['C3PO', 'D.A.R.Y.L.', 'HAL', 'Number 5', 'Wall-e'].sample
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end
end

class RPSGame
  BEST_OF = 3
  attr_accessor :human, :computer, :move_history

  def initialize
    @move_history = Logger.new([], [], [])
    @human = Human.new(move_history)
    @computer = Computer.new(move_history)
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      log_round_to_history
      p move_history
      display_winner
      update_score

      display_score(human)
      display_score(computer)
      if game_over?
        break unless play_again?
        reset_score
      end
    end
    display_stats if user_wants_stats?
    display_goodbye_message
  end

  private

  def stats_header
    border
    puts '|  ' + 'Round'.center(10.75) +
         '|'   + "#{human.name}'s move".center(22.75) +
         '|'   + "#{computer.name}'s move".center(22.75) +
         '|'   + 'Outcome'.center(18.75) +
         ' |'
    border
  end

  def display_stats
    stats_header
    round = 1

    results = move_history.human_moves.zip(
      move_history.computer_moves,
      move_history.results
    )

    results.each do |result|
      puts '|  ' + round.to_s.center(10.75) +
           '|'   + result[0].center(22.75) +
           '|'   + result[1].center(22.75) +
           '|'   + result[2].center(18.75) +
           ' |'
      border
      round += 1
    end
  end

  def round_result
    if human_won?
      "win"
    elsif computer_won?
      "lose"
    else
      "draw"
    end
  end

  def user_wants_stats?
    puts "Would you like to see the game stats?"
    answer = nil

    loop do
      answer = gets.chomp
      break if ['y', 'yes', 'n', 'no'].include? answer.downcase
      puts "Sorry you must enter 'y' or 'n'."
    end

    return false if ['n', 'no'].include? answer.downcase
    return true if ['y', 'yes'].include? answer.downcase
  end

  def log_round_to_history
    move_history.human_moves << human.move
    move_history.computer_moves << computer.move
    move_history.results << round_result
  end

  def reset_score
    human.score.members.each do |member|
      human.score[member] = 0
    end

    computer.score.members.each do |member|
      computer.score[member] = 0
    end
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock"
  end

  def display_goodbye_message
    puts "Thank you for playing, Goodbye"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def decision
    # key beats its values
    {
      rock: ['scissors', 'lizard'],
      paper: ['rock', 'spock'],
      scissors: ['paper', 'lizard'],
      lizard: ['spock', 'paper'],
      spock: ['scissors', 'rock']
    }
  end

  def human_won?
    decision[human.move.to_sym].include? computer.move
  end

  def computer_won?
    decision[computer.move.to_sym].include? human.move
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

  def adjust_score_for_human_win
    human.score.wins += 1
    computer.score.losses += 1
  end

  def adjust_score_for_computer_win
    computer.score.wins += 1
    human.score.losses += 1
  end

  def adjust_score_for_draw
    human.score.draws += 1
    computer.score.draws += 1
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

  def display_score(player)
    puts player.name.to_s.ljust(20) +
         "Wins: #{player.score.wins}".rjust(20) +
         "Losses: #{player.score.losses}".rjust(20) +
         "Draws: #{player.score.draws}".rjust(20)
    border
  end

  def border
    puts "-" * 80
  end

  def game_over?
    (human.score.wins == BEST_OF) || (computer.score.wins == BEST_OF)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ['y', 'yes', 'n', 'no'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if ['n', 'no'].include? answer.downcase
    return true if ['y', 'yes'].include? answer.downcase
  end
end

RPSGame.new.play
