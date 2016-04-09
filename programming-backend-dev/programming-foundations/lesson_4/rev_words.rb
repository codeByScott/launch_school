word = 'icecream'

def reverse(string)
  arr = string.split('')
  rev_arr = []
  
  arr.length.times { rev_arr << arr.pop }
 
  rev_arr.join
end

p reverse(word)
