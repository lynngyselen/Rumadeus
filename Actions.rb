require 'Telnet'
require 'Util'
require 'Objects'

class Actions

	def hold(date, flightnumber, klasse, gender, firstname, surname)
		return Telnet.new.query "H"
		  + (Util.lengthCheck date, 10)
      + (Util.lengthCheck fligthnumber, 6)
      + (Util.lengthCheck klasse, 1)
      + (Util.lengthCheck gender, 1)
      + (Util.stringValidate firstname, 15)
      + (Util.stringValidate surname, 20)
  end
	
	def book(code)
	  result = []
    (Telnet.new.query "B" + (Util.lengthCheck code, 32)).each { |r|
      result << Booking.new(r)
    }
    return result
	end

  def cancel(code)
    return Telnet.new.query "X" +(Util.lengthCheck code, 32)
  end

  def query(code)
    result = []
    (Telnet.new.query "Q"+(Util.lengthCheck code,32)).each { |r|
      result << Booking.new(r)
    }
    return result
  end

end
