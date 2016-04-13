# good_dog_class.rb

module Walkable
  def walk
    "I'm walking"
  end
end

module Swimmable
  def swim
    "I'm swimming"
  end
end

class Animal
  def speak
    "Hello"
  end
end

class GoodDog < Animal
  DOG_YEARS = 7
  attr_accessor :name, :age
  
  def initialize(name, age)
    self.name = name
    self.age = age * DOG_YEARS
  end
  
  def speak
    super + " from GoodDog class"
  end
  
  include Walkable
  include Swimmable
  
  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end
  
  private
  
  def human_years
    self.age / DOG_YEARS
  end
end

class Cat < Animal
end

sparky = GoodDog.new('Sparky', 5)
paws = Cat.new

puts sparky.speak
puts paws.speak
puts sparky.walk
puts sparky.swim
puts GoodDog.ancestors
puts sparky.public_disclosure