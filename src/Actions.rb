require 'AbstractQuery'
require 'MultipleBookings'
require 'Util'
require 'utilities/Booking'
require 'utilities/BookingCode'

class Actions < AbstractQuery
    
  def initialize
    super
  end

	def hold(date, flightnumber, klasse, gender, firstname, surname) 
    query = "H" + 
        (Util::lengthCheck date, 10) +
        (Util::lengthCheck flightnumber, 6) +
        (Util::lengthCheck klasse, 1) +
        (Util::lengthCheck gender, 1) +
        (Util::stringValidate firstname, 15)+
        (Util::stringValidate surname, 20)
    output = @telnet.query query
    if output[0].start_with? "S"
      hold = [BookingCode.new(output[0])]
    elsif output[0].include? "FN"
      raise Util::ReservationError, "No seat available in specified category" 
    end
    hold
  end
  alias :query_hold :hold
 
	
	def book(code)

    output = @telnet.query ("B" + (Util::lengthCheck code, 32))
    if output[0].start_with? "S"
      book = [Booking.new(output[0])]
    elsif (output[0].start_with? "FN")
      raise Util::ReservationError, "No booking available"
    elsif (output[0].start_with? "FA")
      raise Util::ReservationError, "Seat already booked"  
    end
    book
	end
  alias :query_book :book


  def cancel(code)
    output = @telnet.query ("X" + (Util::lengthCheck code, 32))
     if output[0].start_with? "S" 
       ["Successfully cancelled"]
     elsif (output[0].include? "FN") 
       raise Util::ReservationError, "Invalid booking code"
     elsif (output[0].include? "FA") 
       raise Util::ReservationError, "Booking is older than 24h and can't be cancelled"  
    end
  end
  alias :query_cancel :cancel
  

  def query(code)
    output = @telnet.query ("Q" + (Util::lengthCheck code, 32))
    if output[0].start_with? "FN"
      raise Util::ReservationError, "No holding or booking"
    else
      result = [Booking.new(output[0])]
    end
    result
  end
  alias :query_query_booking :query

  # The chain of command can be extended by overriding or monkey patching this
  # method to insert any other class.
  # The extendor is responsible for proper handling of
  # non-existing classes then.
  def delegate
    MultipleBookings.new
  end

end


