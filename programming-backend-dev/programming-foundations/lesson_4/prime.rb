# prime number is only divisible by one and itself 

def is_prime?(number)
  (2..(number - 1)).each do |divisor|
    return false if number % divisor == 0
  end
  
  true
end

def prime_numbers(num1, num2)
  (num1..num2).select do |number|
    is_prime?(number)
  end
end

p prime_numbers(1, 20)