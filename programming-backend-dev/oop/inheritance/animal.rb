class Animal 
  def a_public_method
    "Will this work? " + self.a_protected_method
  end
  
  protected
  
  def a_protected_method
    "Yes, I'm protected!"
  end
end

animal = Animal.new
puts animal.a_public_method
puts animal.a_protected_method