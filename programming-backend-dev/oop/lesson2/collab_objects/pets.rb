module Swimable
  def swim
    'Swimming!'
  end
end

class Person
  attr_accessor :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def jump
    'Jumping!'
  end
end

class Cat < Pet
end

class Dog < Pet
end

class Bulldog < Dog
end

bob = Person.new('Bob')

kitty = Cat.new('Kitty')
tucker = Cat.new('Tucker')
shadow = Dog.new('Shadow')
bud = Bulldog.new('Bud')

bob.pets << kitty
bob.pets << tucker
bob.pets << shadow
bob.pets << bud

bob.pets.each do |pet|
  puts "#{pet.name} is #{pet.jump}"
end

