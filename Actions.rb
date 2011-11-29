require 'Telnet'

class Actions

	def holding(date,flightnumber,klasse,gender,firstname,surname)
		Telnet.new.query "H"+date+flightnumber+klasse+gender+firstname+surname
	end

end