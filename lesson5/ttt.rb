require "pry"
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_accessor :value

  def initialize
    @squares = {}
    @value = nil
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def join_or(options, delimiter = ", ", separator = "or ")
    case options.size
    when 0 then ''
    when 1 then options.first
    when 2 then options.join(separator)
    else
      options[-1] = "#{separator}#{options.last}"
      options.join(delimiter)
    end
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
    (1..9).each { |key| @squares[key] = Square.new(key) }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker, :value

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker.to_s
  end

  def unmarked?
    marker.to_s.to_i == marker
  end

  def marked?
    marker.to_s.to_i != marker
  end
end

class Player
  attr_accessor :marker, :name, :score
end

class Human < Player
  def initialize
    puts "What's your name?"
    @name = gets.chomp.capitalize
    puts "Please select a marker."
    @marker = gets.chomp.capitalize[0]
    @score = 0
  end

  def moves(board)
    puts "Choose a square (#{board.join_or(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = marker
  end
end

class Computer < Player
  def initialize
    @name = ["HAL", "ROBOCOP", "AI 2.0"].sample
    @marker = "O"
    @score = 0
  end

  def moves(board)
    board[board.unmarked_keys.sample] = marker
    #implement minimax. come back to this.
  end
end

class TTTGame
  attr_reader :board, :human, :computer, :player

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    puts "Who plays first? Press 1 for #{human.name}, 2 for #{computer.name}."
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board
      player = choose_first_player
      loop do
        player.moves(board)
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
        player = switch(player)
      end

      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def choose_first_player
    puts "Who should start first?"
    puts "Press 1 for #{human.name}, 2 for #{computer.name}."
    starter = nil
    loop do
      starter = gets.chomp.to_i
      break if starter == 1 || starter == 2
      puts "Invalid Option."
      puts "Press 1 for #{human.name}, 2 for #{computer.name}."
    end
    starter == 1 ? human : computer
  end

  def switch(player)
    player == human ? computer : human
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
      human.score += 1
    when computer.marker
      puts "Computer won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
    puts "The score is #{human.name}: #{human.score} | #{computer.name}: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
