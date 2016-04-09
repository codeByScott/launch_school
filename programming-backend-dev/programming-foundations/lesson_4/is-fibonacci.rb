require 'bigdecimal'

def is_perfect_square?(num)  
  s = BigDecimal.new(num).sqrt(num)
  s * s == num
end

def is_fibonacci?(num)
  num1 = 5 * num**2 + 4
  num2 = 5 * num**2 - 4
  
  is_perfect_square?(num1) || is_perfect_square?(num2)
end

(0..100).select do |i|
  puts i if is_fibonacci?(i)
end
