class GoodDog
  @@number_of_dogs = 0
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(name, age)
    self.name = name
    self.age = age * DOG_YEARS
    @@number_of_dogs += 1
  end
  
  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs

sparky = GoodDog.new('Sparky', 5)

puts GoodDog.total_number_of_dogs
puts sparky.age