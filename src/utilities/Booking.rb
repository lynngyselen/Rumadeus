require 'date'

require 'utilities/Time'
require 'utilities/Person'

class Booking
  
  def initialize(input)
    @status = input[0]
    @date = Date.parse input[1,11]
    @time = TimeM::parseTime input[11,16]
    @duration = TimeM::parseDuration input[16,21]
    @flightCode = input[21,27]
    @klasse = input[27]
    @person = Person.new input[28,64]
    @price = input[64, 69]
  end
  
  def to_s
    "#{@status} #{@date.to_s} #{@time.to_s} #{@duration.to_s} " + 
      "#{@flightCode} #{@klasse} #{@person.to_s} #{@price}"
  end
  
end
