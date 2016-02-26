# Write a while loop that takes input from the user, 
# performs an action, and only stops when the user 
# types "STOP". Each loop can get info from the user.

puts "What do you want?"
input = gets.chomp
counter = 0

while input != "STOP"
  puts "WHAT WAS THAT?"
  input = gets.chomp
  counter += 1
  if counter > 2
    puts "Just type \'STOP\' if you give up!"
  end
end

