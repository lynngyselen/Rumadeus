require 'date'

require 'utilities/Time'

class Connection
  include Comparable
  
  attr_reader :flightcode, :deptime, :duration, :date, :from, :to, :arrival
  
  def initialize(input, from, to, date)
    @flightcode = input[0..5]
    @deptime = TimeM::parseTime input[6..10]
    @duration = TimeM::parseDuration input[11..15]
    @from = from
    @to = to
    @date = Date.parse date
    @arrival = ((DateTime.parse(@date.to_s+" "+@deptime.to_s).to_time + @duration.hours) +@duration.minutes).to_datetime
  end
  
  def to_s
    "#{@date.to_s} #{@from.to_s} #{@to.to_s} #{@flightcode}" +
      "#{@deptime.to_s} #{@duration.to_s}"
  end
  
    def <=> other
      self.arrival <=> other.arrival
    end
  
end
