require 'Telnet'
require 'LastResort'
require 'Util'
require 'utilities/Booking'


class Actions
    
  def initialize
    @telnet = Telnet.new
  end

	def hold(date, flightnumber, klasse, gender, firstname, surname)
		@telnet.query "H"
		  + (Util::lengthCheck date, 10)
      + (Util::lengthCheck fligthnumber, 6)
      + (Util::lengthCheck klasse, 1)
      + (Util::lengthCheck gender, 1)
      + (Util::stringValidate firstname, 15)
      + (Util::stringValidate surname, 20)
  end
	
	def book(code)
	  result = []
    (@telnet.query "B" + (Util::lengthCheck code, 32) || []).each { |r|
      result << Booking.new(r)
    }
    result
	end

  def cancel(code)
    @telnet.query "X" + (Util::lengthCheck code, 32)
  end

  def query(code)
    result = []
    (@telnet.query "Q" + (Util::lengthCheck code, 32) || []).each { |r|
      result << Booking.new(r)
    }
    result
  end
  
  def method_missing *args
    delegate.public_send *args
  end
  
  # The chain of command can be extended by overriding or monkey patching this
  # method to insert any other class.
  # The extendor is responsible for proper handling of
  # non-existing classes then.
  def delegate
    LastResort.new
  end

end
