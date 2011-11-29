require 'Telnet'
require 'Util'

class Actions

	def holding(date,flightnumber,klasse,gender,firstname,surname)
		Telnet.new.query "H"+date+flightnumber+klasse+gender+(Util.new.StringValidate firstname,15)+(Util.new.StringValidate surname,20)
	end

end