# What method could you use to find out if a Hash contains a specific value in it? 
# Write a program to demonstrate this use.

grades = { discrete_math: "A", intro_security: "A", software_architecture: "in_progress", python_scripting: nil }

puts grades.has_value?(nil)