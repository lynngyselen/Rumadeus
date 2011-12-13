class Holding
 
  attr_reader :status , :bookingcode

 
  def initialize(input)
    @status = input[0]
    @bookingcode = BookingCode.new(input[1..33])

  end