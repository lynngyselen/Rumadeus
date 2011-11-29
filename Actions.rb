require 'Telnet'
require 'Util'

class Actions

	def hold(date,flightnumber,klasse,gender,firstname,surname)
		Telnet.new.query "H"+(Util.new.LengthCheck date,10)
                        +(Util.new.LengthCheck fligthnumber,6)
                        +(Util.new.LengthCheck klasse,1)
                        +(Util.new.LengthCheck gender,1)
                        +(Util.new.StringValidate firstname,15)
                        +(Util.new.StringValidate surname,20)
  end
	
	def book(code)
	  Telnet.new.query "B"+(Util.new.LengthCheck code,32)
	end

  def cancel(code)
    Telnet.new.query "X"+(Util.new.LengthCheck code,32)
  end

  def query(code)
    Telnet.new.query "Q"+(Util.new.LengthCheck code,32)
  end

end