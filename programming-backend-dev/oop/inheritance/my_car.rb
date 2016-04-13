class Vehicle
  def gas_mileage(gallons, miles)
    puts "#{miles / gallons} mpg."
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end
