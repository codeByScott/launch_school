# Write a program that checks if the sequence of characters "lab" exists in the following strings. 
# If it does exist, print out the word. - "laboratory" - "experiment" - "Pans Labyrinth" - "elaborate" - "polar bear"

strings = ['laboratory', 'experiment', 'Pans Labyrinth', 'elaborate', 'polar bear']

strings.each do |string|
  string.match('lab') { puts string }
  #if /lab/ =~ string 
  #  puts string 
  #else 
  #  puts "no match"
  #end
end

