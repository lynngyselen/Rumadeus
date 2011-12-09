require 'utilities/Code'

class Airport
    
  def initialize(input)
    @code = Code.new input[0,3]
    @city = input[3,23]
    @country = input[23,43]
  end
  
  def to_s
    "#{@code.to_s} #{@city} #{@country}"
  end
  
end
