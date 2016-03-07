# Question 8

# In the array:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# Find the index of the first name that starts with "Be"

# This puts the index of the first instance of the word that begins with "Be
p flintstones.index { |word| word.start_with?("Be") }

puts 
# This puts each index that begins with "Be"
flintstones.each_with_index do |word, idx| 
  p idx if word.start_with?("Be")
end

puts
# Launch School Solution
p flintstones.index { |name| name[0, 2] == "Be"}
