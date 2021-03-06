# Write a program that takes a number from the user between 0 and 100 
# and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

def is_between?(num)
  if num.between?(0, 50)
    puts "The number is between 0 and 50"
  elsif num.between?(51, 100)
    puts "The number is between 51 and 100"
  elsif num > 100 
    puts "The number is above 100"
  else
    puts "The number is out of range!"
  end
end

puts "Choose a number between 0 and 100."
num = gets.chomp.to_i

is_between?(num)

