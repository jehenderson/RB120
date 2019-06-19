class Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
  
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

class Dog < Pet
end

class Cat < Pet
    def swim
        'can\'t swim!'
    end
    
    def fetch
        'can\'t fetch!'
    end
end


teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

class BullDog < Dog
  def swim
    'can\'t swim!'
  end
end

frank = BullDog.new
puts frank.speak
puts frank.swim