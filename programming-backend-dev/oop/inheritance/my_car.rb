require 'date'

module Offroadable
  def can_offroad?
    true
  end
end

class Vehicle
  attr_accessor :model, :year
  
  @@vehicle_count = 0
  
  def initialize(model, year)
    @@vehicle_count += 1
    @model = model
    @year = year
  end
  
  def gas_mileage(gallons, miles)
    "#{miles / gallons} mpg."
  end
  
  def age
    "Your #{self.model} is #{calculate_age} years old."
  end
  
  def self.print_vehicle_count
    if @@vehicle_count < 2
      puts "You have #{@@vehicle_count} vehicle."
    else
      puts "You have #{@@vehicle_count} vehicles."
    end
  end
  
  private
  
  def calculate_age
    Date.today.year - self.year
  end
  
end

class Sedan < Vehicle
  NUMBER_OF_DOORS = 4
  NUMBER_OF_WHEELS = 4
  
end

class Truck < Vehicle
  NUMBER_OF_DOORS = 2
  NUMBER_OF_WHEELS = 4
  
  include Offroadable
end

class Motorcycle < Vehicle
  NUMBER_OF_WHEELS = 2
    
end

toyota = Truck.new('4-Runner', 2002)
hyundai = Sedan.new('Elantra', 2013)
harley_davidson = Motorcycle.new('Nightster', 2012)
system 'clear'
Vehicle.print_vehicle_count

puts "Your #{harley_davidson.model} gets #{harley_davidson.gas_mileage(3, 120)}"
puts "Your #{toyota.model} gets #{toyota.gas_mileage(15, 275)}"
puts "Your #{hyundai.model} gets #{hyundai.gas_mileage(10, 380)}"
puts toyota.age
p toyota.can_offroad?
puts Truck.ancestors
puts Sedan.ancestors
puts Motorcycle.ancestors