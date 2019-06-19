class Person
    attr_accessor :first_name, :last_name
    def initialize(full_name)
        parse_full_name(full_name)
    end
    
    def name
        "#{@first_name} #{@last_name}".strip
    end
    
    def name=(full_name)
        parse_full_name(full_name)
    end
    
    def to_s
        name
    end
    
    private
    
    def parse_full_name(full_name)
        self.first_name = name.split[0]
        self.last_name = name.split[1] ? name.split.size > 1 : ""        
    end
end

#bob = Person.new('bob')
#bob.name                  # => 'bob'
#bob.name = 'Robert'
#bob.name             # => 'Robert'

#bob = Person.new('Robert')
#bob.name                  # => 'Robert'
#bob.first_name            # => 'Robert'
#bob.last_name             # => ''
#bob.last_name = 'Smith'
#bob.name                  # => 'Robert Smith'

#bob = Person.new('Robert')
#bob.name                  # => 'Robert'
#bob.first_name            # => 'Robert'
#bob.last_name             # => ''
#bob.last_name = 'Smith'
#bob.name                  # => 'Robert Smith'

#bob.name = "John Adams"
#bob.first_name            # => 'John'
#bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts "The person's name is #{bob}"