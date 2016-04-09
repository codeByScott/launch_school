# my_car.rb

# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :year, :color, :model, :speed_up, :brake, :shut_off
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    
    @speed = 0
  end
  
  def speed_up
    @speed + 1
  end
  
  def brake
    @speed - 1
  end
  
  def car_on?
    true
  end
  
  def info
    if !car_on?
      "The #{color} #{year} #{model} is not on."
    else
      "The #{color} #{year} #{model}'s current speed is #{@speed}."
    end
  end
  
end

car1 = MyCar.new(2008, "Black", "Acura")
puts car1.info
car1.speed_up
puts car1.info
