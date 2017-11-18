ScoreKeeper = Struct.new(:wins, :losses, :draws)

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
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
  def choose
    self.move = Move.new(Move::VALUES.sample).value
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
        break unless play_again?
        reset_score
      end
    end

    display_goodbye_message
  end

  private

  def reset_score
    human.score.wins = 0
    human.score.losses = 0
    human.score.draws = 0
    computer.score.wins = 0
    computer.score.losses = 0
    computer.score.draws = 0
  end

  def display_welcome_message
    puts "Welcome"
  end

  def display_goodbye_message
    puts "Goodbye"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def decision_engine
    {
      rock: ['scissors', 'lizard'],
      paper: ['rock', 'spock'],
      scissors: ['paper', 'lizard'],
      lizard: ['spock', 'paper'],
      spock: ['scissors', 'rock']
    }
  end

  def human_won?
    decision_engine[human.move.to_sym].include? computer.move
  end

  def computer_won?
    decision_engine[computer.move.to_sym].include? human.move
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
    puts "-" * 80
    puts
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
