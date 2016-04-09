VOWELS = %w(a e i o u)

def remove_vowels(string)
  str_arr = string.downcase.split("")
  
  str_arr.each do |char|
    str_arr.delete(char) if VOWELS.include?(char)
  end
  
  p str_arr.join
end

remove_vowels("hello")
remove_vowels("Scott")
remove_vowels("Axel")
