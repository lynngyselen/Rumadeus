require 'AbstractQuery'
require 'LastResort'
require 'Util'
require 'utilities/Booking'

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
      (Util::stringValidate firstname, 15) +
      (Util::stringValidate surname, 20)
		result = @telnet.query query
		if result.length > 0 and (code = result.at 0).start_with? "S"
		  ["Success: #{code[1..code.length]}"]
		else
		  result
		end
  end
  alias :query_hold :hold
	
	def book(code)
	  result = []
    (@telnet.query ("B" + (Util::lengthCheck code, 32))).each do |r|
      result << Booking.new(r)
    end
    result
	end
  alias :query_book :book

  def cancel(code)
    result = @telnet.query ("X" + (Util::lengthCheck code, 32))
    if result.include? "S"
      ["Successfully cancelled"]
    else
      result
    end
  end
  alias :query_cancel :cancel

  def query(code)
    result = []
    (@telnet.query ("Q" + (Util::lengthCheck code, 32))).each do |r|
      result << Booking.new(r)
    end
    result
  end
  alias :query_query_booking :query
  
  # The chain of command can be extended by overriding or monkey patching this
  # method to insert any other class.
  # The extendor is responsible for proper handling of
  # non-existing classes then.
  def delegate
    LastResort.new
  end

end
