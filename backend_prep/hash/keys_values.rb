# Using some of Ruby's built-in Hash methods, 
# write a program that loops through a hash and prints all of the keys. 
# Then write a program that does the same thing except printing the values. 
# Finally, write a program that prints both.

person = { name: 'bob', age: 25, occupation: 'ruby developer' }

person.each_key { |key| puts key}
person.each_value { |value| puts value }
person.each { |key, value| puts "The person's #{key} is #{value}." }