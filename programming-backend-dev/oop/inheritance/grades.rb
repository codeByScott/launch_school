class Student
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  protected
  
  def grade
    @grade
  end
end

bob = Student.new('Bob', 88)
joe = Student.new('Joe', 92)

puts "Well done!" if joe.better_grade_than?(bob)
