# Create an object-oriented number guessing class for numbers in the range 1 to 100, 
# with a limit of 7 guesses per game. The game should play like this:

require "pry"
class GuessingGame
  GAME_RANGE = (1..100)
  
  def initialize
    @guesses = 7
    @winner = rand(100)
  end
  
  def play
    loop do
      choice = guess
      break if win?(choice) || lose?
    end
  end
  
  def guess
    choice = nil
    loop do
      puts "You have #{guesses} guesses remaining."
      puts "Enter a number between #{GAME_RANGE}."
      choice = gets.chomp.to_i
      break if valid?(choice)
      puts "Invalid guess. Enter a number between #{GAME_RANGE}."
    end
    feedback(choice)
    @guesses -= 1
    choice
  end
  
  def valid?(pick)
    GAME_RANGE.include?(pick)
  end
  
  def feedback(pick)
    if pick > winner
      puts "Your choice is too high."
    elsif pick < winner
      puts "Your choice is too low."
    else
      puts "You won!"
    end
  end
  
  def win?(pick)
    pick == winner
  end
  
  def lose?
    guesses == 0
  end
  
  private
  attr_accessor :guesses, :winner
end

game = GuessingGame.new
game.play