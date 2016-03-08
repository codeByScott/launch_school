# Question 1

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

# Figure out the total age of just the male members of the family.
sum_of_ages = 0

def sum_ages(family, ages, sex)
  family.each do |name, info|
    ages += info["age"] if info["gender"] == sex
  end
  ages
end

puts sum_ages(munsters, sum_of_ages, "male")
