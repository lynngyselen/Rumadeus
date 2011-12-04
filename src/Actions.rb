require 'Telnet'
require 'Util'
require 'Objects'

class Actions
    
  def initialize
    @telnet = Telnet.new
  end

	def hold(date, flightnumber, klasse, gender, firstname, surname)
		return @telnet.query "H"
		  + (Util.lengthCheck date, 10)
      + (Util.lengthCheck fligthnumber, 6)
      + (Util.lengthCheck klasse, 1)
      + (Util.lengthCheck gender, 1)
      + (Util.stringValidate firstname, 15)
      + (Util.stringValidate surname, 20)
  end
	
	def book(code)
	  result = []
    (@telnet.query "B" + (Util.lengthCheck code, 32)).each { |r|
      result << Booking.new(r)
    }
    return result
	end

  def cancel(code)
    return @telnet.query "X" +(Util.lengthCheck code, 32)
  end

  def query(code)
    result = []
    (@telnet.query "Q"+(Util.lengthCheck code,32)).each { |r|
      result << Booking.new(r)
    }
    return result
  end

end
