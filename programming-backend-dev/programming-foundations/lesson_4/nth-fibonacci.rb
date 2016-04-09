PHI = 5**0.5*0.5+0.5

def nth_fibonacci(n)
  (PHI**n / 5**0.5).round
end

p nth_fibonacci(8)PHI