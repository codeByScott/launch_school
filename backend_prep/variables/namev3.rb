# Modify name.rb again so that it first asks the user for their first name, 
# saves it into a variable, and then does the same for the last name. 
# Then outputs their full name all at once.

puts "What is your first name?"
first_name = gets.chomp.downcase
puts "What is your last name?"
last_name = gets.chomp.downcase

puts "Hello, #{first_name.capitalize} #{last_name.capitalize}!"