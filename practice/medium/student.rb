# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students have a name and year associated with them.

# Add or alter no more than 5 lines

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student #line1
  def initialize(name, year, parking)
      super(name, year) #line3
      @parking = parking
  end
end

class Undergraduate < Student #line2
  def initialize(name, year)
    super
  end
end