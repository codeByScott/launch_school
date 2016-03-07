# Question 3

# In the previous exercise we added Dino to our array like this:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# flintstones << "Dino"

# We could have used either Array#concat or 
# Array#push to add Dino to the family.

# How can we add multiple items to our array? (Dino and Hoppy)

flintstones.push "Dino", "Hoppy"

p flintstones

# Launch School Solutions
flintstones.push("Dino").push("Hoppy")
flinstones.concat(%w(Dino Hoppy))

