################################################
# PSEUDO CODE
################################################

# Given a collection of integers.

# Iterate through the collection one by one.
# - save the first as the starting value.
# - for each iteration, compare the saved value with the current value
# - if the saved value is greater, or it's the same
#  - move to the next value in the collection
# - otherwise, if the current value is greater
#  - reassign the saved as the current value

# After iterating through the collection, return the saved value.

################################################
# FORMAL PSEUDO CODE
# using:
# START
# SET
# GET
# PRINT
# READ
# IF / ELSE IF / ELSE
# WHILE
# END
################################################

# START

# Given a collection of integers called "numbers"

# SET iterator = 1
# SET saved_number = value within numbers collection at space 1

# WHILE iterator < length of numbers
#   SET current_number = value within numbers collection at space "iterator"
#   IF saved_number <= current_number
#     go to the next iteration
#   ELSE
#     saved_number = current_number

#  iterator = iterator + 1

# PRINT saved_number

# END

################################################
# Translated to RUBY
################################################

def find_greatest(numbers)
  saved_number = nil
  #return if numbers.nil || numbers.empty?
  numbers.each do |num|
    saved_number ||= num
    if saved_number >= num
      next
    else
      saved_number = num
    end
  end
  saved_number
end

puts find_greatest([1, 4, 9, 14, 5, 6])








