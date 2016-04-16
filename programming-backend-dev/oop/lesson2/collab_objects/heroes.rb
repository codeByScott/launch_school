class Person
  def initialize
    @heroes = [ 'Superman', 'Spiderman', 'Batman' ]
    @cash = { 'ones': 12, 'fives': 2, 'tens': 0, 'twenties': 2, 'hundreds': 0 }
  end
  
  def cash_value(value)
    
    case value
      when :ones
        return 1
      when :fives
        return 5
      when :tens
        return 10
      when :twenties
        return 20
      when :hundreds
        return 100
      else
        0
    end
  end
  
  def cash_on_hand
    total_value = 0
    @cash.each { |value, qty| total_value += cash_value(value) * qty } 
    "Total cash: $#{'%.2f' % total_value}"
  end
  
  def heroes
    "Heroes: #{@heroes.join(', ')}"
  end
  
end

joe = Person.new
p joe.cash_on_hand            # => "$62.00"
p joe.heroes                  # => "Superman, Spiderman, Batman"