# good_dog.rb

module Speak
  def speak
    "#{name} says Arf!"
  end
end

class GoodDog
  attr_accessor :name, :age, :weight
  
  def initialize(name)
    @name = name
  end
  
  def self.what_am_i?
    "I'm a GoodDog class!"
  end
  
  include Speak
end

sparky = GoodDog.new('Sparky')
p sparky.speak
p sparky.name
p sparky.name = 'Spartacus'
p sparky.weight = 23.45
p sparky.age = 5
puts
shadow = GoodDog.new('Shadow')
p shadow.speak
p shadow.name
p sparky.name
puts
p GoodDog.what_am_i?