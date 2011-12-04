class Person
  
  def initialize(input)
    input =~ /([MF])([A-Za-z ]{15})([A-Za-z ]{20})/
    @gender = $1
    @firstname = $2
    @surname = $3  
  end
  
  def to_s
    (@gender.to_s) + " " + (@firstname.to_s) + " " + (@surname.to_s)
  end
  
end
