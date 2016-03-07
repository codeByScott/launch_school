# Question 9

# Given the munsters hash below
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an additional "age_group" key 
# that has one of three values describing the age group the family member is in (kid, adult, or senior). 
# kid(0 - 17), adult(18 - 64), senior(65 +)
# hint: try using a case statement along with Ruby Range objects in your solution

munsters.each do |key, value| 
  case value["age"]
  when (0..17)
    value["age_group"] = 'kid'
  when (18..64)
    value["age_group"] = 'adult'
  else
    value["age_group"] = 'senior'
  end
end

p munsters
