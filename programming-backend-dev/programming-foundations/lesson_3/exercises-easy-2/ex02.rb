# Question 2

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum_ages = 0
ages.each_value do |ages|
  sum_ages += ages
end

p sum_ages

# Launch Schools solution...much more concise of course!
p ages.values.inject(:+)
