require 'utilities/Code'

class Airline
  
  def initialize(input)
    @code = input[0,3]
    @name = input[4,34]
  end
  
  def to_s
    "#{@code} #{@name}"
  end
  
end
