def fib(n, cache)
  return 1 if n <= 2
  return cache[n] if cache[n]
  cache[n] = fib(n - 1, cache) + fib(n - 2, cache)
end

cache = []
fibonacci_numbers = (1..100).map { |i| fib(i, cache)}
p fibonacci_numbers