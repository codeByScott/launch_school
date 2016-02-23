# Use the modulo operator, division, or a combination of both to take a 4 digit number and find 1) the thousands number 2) the hundreds 3) the tens and 4) and the ones.
# I went a little overboard.  Having fun trying to figure out how to do higher numbers and formatting.

num = 0
print "Enter a number (up to 99,999): "
num = gets.strip.to_i
comma = ","

ten_thousands_place = num / 10000
thousands_place = num % 10000 / 1000
hundreds_place = num % 1000 / 100 
tens_place = num % 100 / 10
ones_place = num % 10

puts "Ten Thousands place: #{ten_thousands_place}" if num.to_s.size > 4
puts "Thousands place: #{thousands_place}" if num.to_s.size > 3
puts "Hundreds place: #{hundreds_place}" if num.to_s.size > 2
puts "Tens place: #{tens_place}" if num.to_s.size > 1
puts "Ones place: #{ones_place}"
puts

puts "$#{ten_thousands_place if num.to_s.size > 4}#{thousands_place if num.to_s.size > 3}#{comma if num.to_s.size > 3}#{hundreds_place if num.to_s.size > 2}#{tens_place if num.to_s.size > 1}#{ones_place}.00"
puts




