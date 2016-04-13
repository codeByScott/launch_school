# my_car.rb

class MyCar
  
  attr_accessor :color
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    
    @current_speed = 0
  end
  
  def current_speed
    puts "Your current speed is #{@current_speed}."
  end
  
  def accelerate(mph)
    @current_speed += mph
    puts "You have accelerated by #{mph} miles per hour."
  end
  
  def brake(mph)
    @current_speed -= mph
    puts "You have slowed down #{mph} miles per hour."
  end
  
  def turn_off
    @current_speed = 0
    puts "You have turned the vehicle off."
  end
  
  def spray_paint(color)
    self.color = color
  end
  
  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
  end
  
  def to_s
    "My car is a #{color}, #{year}, #{@model.upcase}!"
  end
  
end

acura = MyCar.new(2008, 'black', 'tl')
acura.current_speed
acura.accelerate(60)
acura.current_speed
acura.brake(10)
acura.current_speed
acura.turn_off
acura.current_speed
puts
acura.spray_paint('white')
puts acura.color
puts MyCar.gas_mileage(400, 20)
puts acura