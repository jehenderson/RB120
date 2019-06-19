#Come back to this. You are trying to make a subclass for each movels


class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  def initialize(choice)
    @value = choice
  end

  def to_s
    @value
  end

  # def rock?
  #   @value == 'rock'
  # end

  # def scissors?
  #   @value == 'scissors'
  # end

  # def paper?
  #   @value == 'paper'
  # end
  
  # def lizard?
  #   @value == 'lizard'
  # end
  
  # def spock?
  #   @value == 'spock'
  # end

  # def >(other_move)
  #   # rock? && (other_move.scissors? || other_move.lizard?) ||
  #   #   paper? && (other_move.rock? || other_move.spock?) ||
  #   #   scissors? && (other_move.paper? || other_move.lizard?) ||
  #   #   lizard? && (other_move.spock? || other_move.paper?) ||
  #   #   spock? && (other_move.rock? || other_move.scissors?)
  # end
end

class Rock < Move
  
end

class Paper < Move
end

class Scissors < Move
end

class Lizard < Move
end

class Spock < Move
end

class Player
  attr_accessor :name, :move, :points
  def initialize
    @move = nil
    @points = 0
    set_name
  end
  
  def wins
    puts "#{@name} wins!"
    @points += 1
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What\'s your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{Move::VALUES.join(', ')}:"
      choice = gets.chomp
      break if Move::VALUES.include?choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', '#5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Engine
class RPSGame
  attr_accessor :human, :computer, :game

  def initialize
    @human = Human.new
    @computer = Computer.new
    @game = 1
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"

    if human.move > computer.move
      human.wins
    elsif computer.move > human.move
      computer.wins
    else
      puts "It's a tie!"
    end
    
    puts "Score - #{human.name}: #{human.points} | #{computer.name}: #{computer.points}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?answer.downcase
      puts "Sorry, must be y or n."
    end
    return true if answer == 'y'
    false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
      @game += 1
    end
    display_goodbye_message
  end
end

RPSGame.new.play
