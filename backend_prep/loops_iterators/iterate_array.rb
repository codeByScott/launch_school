# Use the each_with_index method to iterate 
# through an array of your creation that prints 
# each index and value of the array.

belt_ranks = ["white", "blue", "purple", "brown", "black"]

belt_ranks.each_with_index { |rank, index| puts "#{index} #{rank}" }