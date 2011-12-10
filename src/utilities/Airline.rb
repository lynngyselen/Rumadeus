require 'utilities/Code'

class Airline
  
  attr_reader :code, :name
  
  def initialize input
    @code = input[0..2]
    @name = input[3..32]
  end
  
  def to_s
    "#{@code} #{@name}"
  end
  
end
