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
  
  def arrival_time
    departure_time = DateTime.parse("#{@date.to_s} #{@deptime.to_s}").to_time
    departure_time += @duration.hours * 60 * 60
    departure_time += @duration.minutes * 60
  end
  
  def to_s
    "#{@date.to_s} #{@from.to_s} #{@to.to_s} #{@flightcode}" +
      "#{@deptime.to_s} #{@duration.to_s}"
  end
  
  def == other
    self.flightcode == other.flightcode
    self.deptime == other.deptime
    self.duration == other.duration
    self.from == other.from
    self.to == other.to
    self.date == other.date
  end
  
end
