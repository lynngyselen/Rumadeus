require 'date'

require 'utilities/Time'

class Connection
  
  attr_reader :flightcode, :deptime, :duration, :date, :from, :to 
  
  def initialize(input, from, to, date)
    @flightcode = input[0..5]
    @deptime = TimeM::parseTime input[6..10]
    @duration = TimeM::parseDuration input[11..15]
    @from = from
    @to = to
    @date = Date.parse date
  end
  
  def to_s
    "#{@date.to_s} #{@from.to_s} #{@to.to_s} #{@flightcode}" +
      "#{@deptime.to_s} #{@duration.to_s}"
  end
  
end
