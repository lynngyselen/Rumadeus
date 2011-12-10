require 'date'

require 'utilities/Time'
require 'utilities/Person'

class Booking
  
  attr_reader :status, :date, :time, :duration
  attr_reader :flightcode, :class, :person, :price 
  
  def initialize(input)
    @status = input[0]
    @date = Date.parse input[1..10]
    @time = TimeM::parseTime input[11..15]
    @duration = TimeM::parseDuration input[16..20]
    @flightcode = input[21..26]
    @class = input[27]
    @person = Person.new input[28..63]
    @price = input[64..68].to_i
  end
  
  def to_s
    "#{@status} #{@date.to_s} #{@time.to_s} #{@duration.to_s} " + 
      "#{@flightcode} #{@class} #{@person.to_s} #{@price.to_s}"
  end
  
end
