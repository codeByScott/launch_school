# Write a program that prints out groups of words that are anagrams. 
# Anagrams are words that have the same exact letters in them 
# but in a different order. 
# Your output should look something like this:
# ["demo", "dome", "mode"]
# ["neon", "none"]
# (etc)

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

anagrams = {}

words.each do |word|
  check = word.split("").sort.join
  if anagrams.has_key?(check)
    anagrams[check].push(word)
  else
    anagrams[check] = [word]
  end
end

anagrams.each do |k, v|
  p v
end


