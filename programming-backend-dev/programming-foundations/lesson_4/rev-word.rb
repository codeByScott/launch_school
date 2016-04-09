word = 'icecream'

def reverse(string)
  arr = string.split('')
  rev_arr = []
  
  arr.each do |char|
    rev_arr << arr.pop
  end
  
  rev_arr
end


p reverse(word)