class Person
  
  def initialize(input)
    @gender = input[0]
    @firstname = input[1, 16]
    @surname = input[16, 36]
  end
  
  def to_s
    "#{@gender} #{@fiirstname} #{@surname}"
  end
  
end
