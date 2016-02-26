# Write a program called name.rb
# that asks the user to type in their name and 
# then prints out a greeting message with their name included.

puts "What is your name?"
name = gets.chomp.downcase
puts "Hello, #{name.capitalize}!"