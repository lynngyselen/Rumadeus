require 'Util'

class BookingCode
  
  attr_reader :code
  
  def initialize(input)
    @code = Util::lengthCheck(input,32)
  end
  
  def to_s
    @code
  end
end
