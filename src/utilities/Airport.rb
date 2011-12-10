require 'utilities/Code'

class Airport
  
  attr_reader :code, :city, :country
    
  def initialize input
    @code = Code.new input[0..2]
    @city = input[3..22]
    @country = input[23..42]
  end
  
  def to_s
    "#{@code.to_s} #{@city} #{@country}"
  end
  
end
