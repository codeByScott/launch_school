# Question 3

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "Old method output:"
puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# How can we refactor this exercise to make the result easier to predict and easier for the next programmer to maintain?

def tricky_method(a_string_param, an_array_param)
  a_string_param += ' rutabaga'
  an_array_param += ['rutabaga']
  
  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]

my_string, my_array = tricky_method(my_string, my_array)

puts
puts "New method output:"
puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
