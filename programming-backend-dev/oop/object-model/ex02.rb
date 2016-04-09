module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class Person
  include Speak
end

bob = Person.new