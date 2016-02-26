# Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

def factorial(num)
  if num <= 1
    1
  else
    num * factorial(num - 1)
  end
end

puts factorial(5)
puts factorial(6)
puts factorial(7)
puts factorial(8)

# I know, I know...this is too advanced for this section.  But, I am lazy and I learned this in my Discrete math class so figured I would use it.