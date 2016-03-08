# Question 6

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
  demo_hash
end


puts "Original Hash, before messing with it:"
p munsters
puts
puts "Messing with data in the Hash:"
p mess_with_demographics(munsters)
puts
puts "Original Hash, after messing with it:"
p munsters

# This will permanently mutate the original hash.  