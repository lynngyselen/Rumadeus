class Person
  
  attr_reader :gender, :firstname, :surname
  
  def initialize(input)
    @gender = input[0]
    @firstname = input[1..15]
    @surname = input[16..35]
  end
  
  def to_s
    "#{@gender} #{@firstname} #{@surname}"
  end
  
  def == other
    other.gender == self.gender and other.firstname == self.firstname and
      other.surname == self.surname
  end
  
end
