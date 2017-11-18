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

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    RPSGame::WIN_COMBOS.include?([value, other_move.value])
  end

  def to_s
    value
  end
end

class RPSGame
  attr_accessor :human, :computer

  WIN_COMBOS = [
    ['scissors', 'paper'], ['paper', 'rock'], ['rock', 'lizard'],
    ['lizard', 'spock'], ['spock', 'scissors'], ['scissors', 'lizard'],
    ['lizard', 'paper'], ['paper', 'spock'], ['spock', 'rock'],
    ['rock', 'scissors']
  ].freeze

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
      display_score(human)
      display_score(computer)
      break unless play_again?
    end

    display_goodbye_message
  end

  private

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

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score.wins += 1
      computer.score.losses += 1
    elsif computer.move > human.move
      puts "#{computer.name} won!"
      computer.score.wins += 1
      human.score.losses += 1
    else
      puts "It's a tie!"
      human.score.draws += 1
      computer.score.draws += 1
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
end

RPSGame.new.play
