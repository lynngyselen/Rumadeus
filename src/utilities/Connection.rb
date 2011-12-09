require 'utilities/Time'

class Connection
  
  attr_accessor :date, :departure, :arrival
  attr_reader :flightCode 
  
  def initialize(input)
    @flightCode = input[0,6]
    @deptime = TimeM::parseTime input[6,11]
    @duration = TimeM::parseDuration input[11,16]
  end
  
  def to_s
    "#{@date.to_s} #{@departure.to_s} #{@arrival.to_s} #{@flightCode}" +
      "#{@deptime.to_s} #{@duration.to_s}"
  end
  
end
