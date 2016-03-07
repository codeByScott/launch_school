# Question 6

# Starting with the string:
famous_words = "seven years ago..."
# show two different ways to put the expected 
# "Four score and " in front of it.
puts famous_words.split.unshift('Four score and').join(' ')
puts "Four score and " + famous_words

# Launch School solution and much cleaner
puts famous_words.prepend("Four score and ")