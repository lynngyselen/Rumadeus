require 'Util'

class BookingCode
  def initialize(input)
    @code = Util::lengthCheck(input,32)
  end
  
  def to_s
    @code
  end
end
