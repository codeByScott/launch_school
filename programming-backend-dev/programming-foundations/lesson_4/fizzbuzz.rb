def fizzbuzz(num1, num2)
  (num1..num2).each do |element|
    if element == 0
      puts element
    elsif element % 3 == 0 && element % 5 == 0
      puts "fizzbuzz"
    elsif element % 3 == 0
      puts "fizz"
    elsif element % 5 == 0
      puts "buzz"
    else
      puts element
    end
  end
end

fizzbuzz(-8, 30)