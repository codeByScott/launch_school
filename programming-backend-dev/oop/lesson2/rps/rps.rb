# user makes a choice
# computer makes a choice
# winner is displayed

# Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves:

# - rock beats scissors
# - paper beats rock
# - scissors beats paper

# If the players choose the same move, then it is a tie.

# Nouns: player, move, rule
# Verbs: choose, compare

# Player
#  -choose
# Move
# Rule

# - compare

class Player
  
  CHOICES = %w( rock paper scissors )
  attr_accessor :move, :name
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end 
  
  def set_name
    if human?
      n = ''
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, you must enter a name."
      end
      self.name = n.capitalize
    else
      self.name = %w( R2D2 Hal Chappie Sonny ).sample
    end
  end
  
  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose Rock, Paper, or Scissors:"
        choice = gets.chomp.downcase
        break if CHOICES.include?(choice)
        puts "Sorry, invalid choice."
      end
      
      self.move = choice
    else
      self.move = CHOICES.sample
    end
  end
    
    def human?
      @player_type == :human
    end
end

class Move
  def initialize
    # something to keep track?
    
  end
end

class Rule
  def initialize
  
  end
end

def compare(move1, move2)

end

# Game Orchestration Engine
class RPSGame
    
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end
  
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end
  
  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    
    case human.move
      when 'rock'
        puts "It's a tie" if computer.move == 'rock'
        puts "#{human.name} won!" if computer.move == 'scissors'
        puts "#{computer.name} won!" if computer.move == 'paper'
      when 'paper'
        puts "It' a tie" if computer.move == 'paper'
        puts "#{human.name} won!" if computer.move == 'rock'
        puts "#{computer.name} won!" if computer.move == 'scissors'
      when 'scissors'
        puts "It's a tie" if computer.move == 'scissors'
        puts "#{human.name} won!" if computer.move == 'paper'
        puts "#{computer.name} won!" if computer.move == 'rock'
    end
  end
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Good Bye!"
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    
    return true if answer == 'y'
    false
  end
  
  def play
    system 'clear' or system 'cls'
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
