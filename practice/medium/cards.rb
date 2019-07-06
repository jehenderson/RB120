class Card
  include Comparable
  
  attr_reader :rank, :suit
  
  CARD_VALUES = {
    1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 
    10 => 10, 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def <=>(other)
    CARD_VALUES[rank] <=> CARD_VALUES[other.rank]
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end  
  # def min(card_array)
  #   min = 15
  #   card_array.each { |card| min = card.rank if card.rank < min }
  #   min
  # end
  
  # def max(card_array)
  #   max = 0
  #   card_array.each { |card| max = card.rank if card.rank > max }
  #   max
  # end
# end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8