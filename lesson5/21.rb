require "pry"
class Player
  attr_accessor :hand

  def initialize(deck)
    @hand = Array.new
    2.times { hit deck }
  end

  def play(deck)
    system "clear"
    loop do
      show_hand
      hit? ? hit(deck) : break
      if busted?
        puts "Busted!"
        break
      end
    end
  end

  def busted?
    total > 21 ? true : false
  end

  def total
    sum = 0
    hand.each do |card|
      sum += card.points
    end
    aces = hand.select do |card|
      card.value == 'Ace'
    end
    aces.count.times do
      break if total <= 21
      total -= 10
    end
    sum
  end
  
  def hit?
    puts "Hit or stay?"
    gets.chomp.downcase[0] == 'h' ? true : false
  end

  def hit(deck)
    hand.push(deck.deal)
  end

  def show_hand
    hand.each { |card| puts "#{card}" } 
  end
  
end

class Dealer < Player
 
  def play(deck, op_total)
    loop do
      hit(deck) if total < op_total
      break if busted? || total > op_total
    end
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = Array.new
    ['Spade', 'Heart', 'Club', 'Diamond'].each do |suit|
      (2..10).each { |num| cards.push(Card.new(suit, num, num)) }
      ['Jack', 'Queen', 'King', 'Ace'].each do |face|
        face == 'Ace' ? points = 11 : points = 10
        cards.push(Card.new(suit, face, points))
      end
    end
  end

  def shuffle
    cards.sort_by! { rand }
  end

  def deal
    cards.pop
  end
end

class Card
  attr_reader :suit, :value, :points

  def initialize(suit, value, points)
    @suit = suit
    @value = value
    @points = points
  end

  def to_s
    "#{value} of #{suit}s"
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    deck.shuffle
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
  end

  def start
    # deal_cards (this happens in initialize)

    # show_initial_cards
    dealer.show_hand
    player.show_hand
    # player_turn
    player.play(deck)
    # dealer_turn
    dealer.play(deck, player.total)
    # show_result
    puts "Player: #{player.total} | Dealer: #{dealer.total}"
    puts "Player"
    player.show_hand
    puts "Dealer"
    dealer.show_hand
  end
end

Game.new.start
