# Write a method that counts down to zero using recursion.

def count_down(num)
  puts num
  if num > 0
  count_down(num - 1)
  end
end

puts "Choose a number greater than zero (keep it reasonable):"
num = gets.chomp.to_i

count_down(num)