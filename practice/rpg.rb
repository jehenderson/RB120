module Armored
  def attach_armor
  end
  
  def remove_armor
  end
end

module Spellcaster
  def cast_spell(spell)
  end
end

class Player

  attr_reader :name, :strength, :intelligence
  attr_accessor :health
  
  def initialize(name)
    @name = name
    @health = 100
    @strength = roll_dice
    @intelligence = roll_dice
  end
  
  def heal(pts)
    self.health += pts
  end
  
  def hurt(pts)
    self.health -= pts
  end
  
  def to_s
    "Name: #{name} \nClass: #{self.type}\nHealth: #{health}\nStrength: #{strength}\nIntelligence: #{intelligence}"
  end
  
  private
  
  def roll_dice
    rand(2..12)
  end
end

class Warrior < Player
  def initialize
    super
    @strength += 2
  end
end

class Paladin < Player
  include Armored
  include Spellcaster
end

class Magician < Player
  include Spellcaster
  
  def initialize
    super
    @intelligence += 2
  end
end

class Bard < Magician
  def create_potion
    
  end
end