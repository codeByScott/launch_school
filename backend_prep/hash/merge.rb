# Look at Ruby's merge method. Notice that it has two versions. 
# What is the difference between merge and merge!? 
# Write a program that uses both and illustrate the differences.

person = {name: 'Scott', sex: 'male'}

people = {career: 'software engineer'}

puts person.merge(people)
puts person
puts people
puts person.merge!(people)
puts person
puts people