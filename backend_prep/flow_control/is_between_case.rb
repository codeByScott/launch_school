# Rewrite your program from exercise 3 using a case statement. 
# Wrap each statement in a method and make sure they both still work.

def is_between?(num)
  case num
  when 0..50
    puts "Your number is between 0 and 50."
  when 51..100
    puts "Your number is between 51 and 100."
  else 
    if num > 100
    puts "Your number is greater than 100."
    else
    puts "Your number is out of range!"
    end
  end
end

puts "Choose a number between 0 and 100:"
num = gets.chomp.to_i

is_between?(num)