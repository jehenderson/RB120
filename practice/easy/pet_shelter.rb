class Owner
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = Array.new
  end
  
  def number_of_pets
    pets.size
  end
end

class Pet
  @@all = Array.new
  def initialize(pet_type, name)
    @pet_type = pet_type
    @name = name
    @@all.push(self)
  end
  
  def self.all
    @@all
  end
  
  def to_s
    "a #{pet_type} named #{name}"
  end
  
  private
  attr_reader :pet_type, :name
end

class Shelter
  def initialize
    @owners = Array.new
    @inventory = Pet.all
    @customers = Hash.new
  end
  
  def adopt(owner, pet)
    owner.pets.push(pet)
    @inventory.delete(pet)
    customers[owner.name] ||= owner
  end
  
  def print_adoptions
    customers.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.pets.each { |pet| puts pet }
      puts ""
    end
  end
  
  private
  attr_accessor :customers
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.