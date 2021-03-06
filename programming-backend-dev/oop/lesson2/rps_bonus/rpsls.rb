ScoreKeeper = Struct.new(:wins, :losses, :draws)
Logger = Struct.new(:human_moves, :computer_moves, :results)

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def green
    colorize(32)
  end

  def truncate
    if size <= 12
      self
    else
      split = self.split('')
      (size - 12).times do
        split.delete_at(-1)
      end
      split.join('') + "..."
    end
  end
end

module Strategies
  def beat_opponents_last_move
    if move_history.human_moves.empty?
      Move::VALUES.sample
    else
      move_that_beats[opponents_last_move.to_sym]
    end
  end

  def beat_opponents_best_move
    move_that_beats[opponents_best_move.to_sym]
  end

  private

  def move_that_beats
    # The values beat their keys
    {
      rock: 'paper',
      paper: 'scissors',
      scissors: 'spock',
      lizard: 'rock',
      spock: 'lizard'
    }
  end

  def opponents_last_move
    move_history.human_moves.last
  end

  def opponents_winning_moves
    winning_moves = []
    move_history.results.each_with_index do |result, idx|
      winning_moves << move_history.human_moves[idx] if result == "win"
    end
    winning_moves
  end

  def opponents_best_move
    # the opponents move that wins the most, or the last move if no wins
    winning_moves = opponents_winning_moves
    moves = winning_moves.any? ? winning_moves : opponents_last_move.split
    moves.max_by { |move| moves.count move }
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize(move_history)
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
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.strip.empty?
      puts "Sorry, you must enter a value."
    end
    self.name = name
  end
end

class Computer < Player
  include Strategies

  def initialize(move_history)
    super
    set_name
  end

  private

  def my_first_round?
    move_history.computer_moves.empty?
  end
end

class C3PO < Computer
  def set_name
    self.name = 'C3PO'
  end

  def choose
    self.move = Move.new(Move::VALUES.sample).value
  end
end

class Daryl < Computer
  def set_name
    self.name = 'D.A.R.Y.L.'
  end

  def choose
    self.move = if my_first_round?
                  # based on the famous RPS game between Sotheby's & Christie's
                  Move.new("scissors").value
                else
                  Move.new(beat_opponents_best_move).value
                end
  end
end

class Hal < Computer
  def set_name
    self.name = 'HAL'
  end

  def choose
    self.move = Move.new(beat_opponents_last_move).value
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
  ROUNDS_TO_WIN = 3
  WIDTH = 80
  attr_accessor :human, :computer, :move_history

  def initialize
    @move_history = Logger.new([], [], [])
    @human = Human.new(move_history)
    @computer = [
      C3PO.new(move_history),
      Hal.new(move_history),
      Daryl.new(move_history)
    ].sample
  end

  def play
    display_welcome_screen
    get_player_name(human)
    display_ready_screen

    loop do
      players_choose
      log_round_and_update_score
      update_display
      display_round_results

      if game_over?
        break unless play_again?
        reset_display
      end
    end
    display_stats if user_wants_stats?
    display_footer
  end

  private

  def update_display
    clear_display
    display_game_title
    display_score(human)
  end

  def reset_display
    reset_score
    update_display
  end

  def players_choose
    human.choose
    computer.choose
  end

  def log_round_and_update_score
    log_round_to_history
    update_score
  end

  def display_welcome_screen
    clear_display
    display_game_title
    display_rules
    display_rounds_to_win
  end

  def display_ready_screen
    clear_display
    display_game_title
    display_opponents_name
  end

  def display_opponents_name
    puts ""
    puts "Hi, #{human.name.truncate} you will be playing against"\
         " #{computer.name}.".center(WIDTH)
    puts ""
  end

  def display_rounds_to_win
    puts
    puts "First to win #{ROUNDS_TO_WIN} rounds is the champion.".center(WIDTH)
    puts
  end

  def display_rules
    puts "Scissors cuts Paper covers Rock crushes Lizard poisons Spock "\
         "smashes\nScissors decapitates Lizard eats Paper disproves Spock "\
         "vaporizes\nRock crushes Scissors"
  end

  def display_game_title
    display_border
    puts "ROCK, PAPER, SCISSORS, LIZARD, SPOCK".ljust(WIDTH * 0.625) +
         "Created by CodeByScott".rjust(WIDTH * 0.375).green
    display_border
  end

  def clear_display
    system('clear') || system('clr')
  end

  def stats_header
    display_border
    puts stats_header_col_one   +
         stats_header_col_two   +
         stats_header_col_three +
         stats_header_col_four
    display_border
  end

  def stats_header_col_one
    '|  ' + 'Round'.center(WIDTH * 0.134375)
  end

  def stats_header_col_two
    '|' + "#{human.name.truncate}'s move".center(WIDTH * 0.284375)
  end

  def stats_header_col_three
    '|' + "#{computer.name}'s move".center(WIDTH * 0.284375)
  end

  def stats_header_col_four
    '|' + 'Outcome'.center(WIDTH * 0.234375) + ' |'
  end

  def display_stats
    clear_display
    display_game_title
    stats_header
    stats_round_data
  end

  def stats_col_one(round)
    '|  ' + round.to_s.center(WIDTH * 0.134375)
  end

  def stats_col_two(result)
    '|' + result[0].center(WIDTH * 0.284375)
  end

  def stats_col_three(result)
    '|' + result[1].center(WIDTH * 0.284375)
  end

  def stats_col_four(result)
    '|' + result[2].center(WIDTH * 0.234375) + ' |'
  end

  def stats_round_data
    round = 1

    results = move_history.human_moves.zip(
      move_history.computer_moves,
      move_history.results
    )

    results.each do |result|
      puts  stats_col_one(round) +
            stats_col_two(result) +
            stats_col_three(result) +
            stats_col_four(result)
      display_border
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

  def display_footer
    puts "*" * WIDTH
    puts "-" * WIDTH
    puts "The RPSLS game was originally created by Sam Kass".center(WIDTH)
    puts "-" * WIDTH
  end

  def moves
    "#{human.name.truncate} chose #{human.move}, "\
    " #{computer.name} chose #{computer.move}."
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

  def winner
    if human_won?
      "#{human.name.truncate} won!"
    elsif computer_won?
      "#{computer.name} won!"
    else
      "It's a tie!"
    end
  end

  def display_round_results
    puts
    puts "#{moves} #{winner}".center(WIDTH)
    puts
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
    puts player.name.truncate.ljust(WIDTH * 0.25) +
         display_wins(player) +
         display_losses(player) +
         display_draws(player)
    display_border
  end

  def display_wins(player)
    "Wins: #{player.score.wins}".rjust(WIDTH * 0.25)
  end

  def display_losses(player)
    "Losses: #{player.score.losses}".rjust(WIDTH * 0.25)
  end

  def display_draws(player)
    "Draws: #{player.score.draws}".rjust(WIDTH * 0.25)
  end

  def get_player_name(player)
    player.set_name
  end

  def display_border
    puts "-" * WIDTH
  end

  def game_over?
    (human.score.wins == ROUNDS_TO_WIN) ||
      (computer.score.wins == ROUNDS_TO_WIN)
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
