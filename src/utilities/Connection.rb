require 'utilities/Time'

class Connection
  
  attr_accessor :date, :departure, :arrival
  attr_reader :flightCode 
  
  def initialize(input)
    input =~ /(\w{3}\d{3})([0-9:]{5})([0-9:]{5})/
    @flightCode = $1
    @deptime = TimeM::parseTime $2
    @duration = TimeM::parseDuration $3   
  end
  
  def to_s
    (@date.to_s) + " " + (@departure.to_s) + " " + (@arrival.to_s) + " " + 
      (@flightCode.to_s) + " " + (@deptime.to_s) + " " + (@duration.to_s)
  end
  
end
