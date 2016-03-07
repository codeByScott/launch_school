# Question 7

# Ben coded up this implementation but complained that as soon as he ran it, he got an error. 
# Something about the limit variable. What's wrong with the code?

# limit = 15

# def fib(first_num, second_num)
#  while second_num < limit
#    sum = first_num + second_num
#    first_num = second_num
#    second_num = sum
#  end
#  sum
# end

# result = fib(0, 1)
# puts "result is #{result}"

limit = 15

def fibonacci(num1, num2, limit= 20)
  while num2 < limit
    sum = num1 + num2
    num1 = num2
    num2 = sum
  end
  sum
end

result = fibonacci(0, 1, limit)
puts "Result is #{result}"