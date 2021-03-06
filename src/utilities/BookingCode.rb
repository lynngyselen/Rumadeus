require 'Util'

class BookingCode
  
  attr_reader :status, :code
  
  def initialize(input)
    Util::lengthCheck(input,33)
    @status = input[0]
    @code = input[1..33]
  end
  
  def to_s
     "Booking, code: #{@code.to_s}"
  end
end
