# Question 2

# Create a hash that expresses the frequency with which each letter occurs in this string:
statement = "The Flintstones Rock"

char_frequency = Hash.new
chars = ('a'..'z').to_a

chars.each do |char|
  frequency = statement.downcase.scan(char).count
  char_frequency[char] = frequency if frequency > 0
end

p char_frequency