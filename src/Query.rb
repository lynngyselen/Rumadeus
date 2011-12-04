require 'Telnet'
require 'Objects'

class Query
  
  def initialize
    @telnet = Telnet.new
  end
  
  def version
    @telnet.query "V"
  end
  
  def listAirlines
    result = []
    (@telnet.query "A").each { |r|
      result << Airline.new(r)
    }
    result
  end
  
  def listAirports
    result = []
    (@telnet.query "P").each { |r|
      result << Airport.new(r)
    }
    result
  end
  
  def listDestinations(airport)
    result = []
    (@telnet.query "D" + airport).each { |r|
      result << Code.new(r)
    }
    result
  end
  
  def listConnections(date,source, destination)
    result = []
    (@telnet.query "C" + source + destination + date).each { |r|
      con = Connection.new(r)
      con.departure = source
      con.arrival = destination
      con.date = Date.new(date)
      result << con
    }
    result
  end
  
  def listLocations(flight)
    @telnet.query "F" + flight
  end
  
  def listFlightDays(flight)
    @telnet.query "W" + flight 
  end
  
  def listSeats(date, flight, type)
    result = []
    (@telnet.query "S" + date.to_s + flight + type).each { |r|
      result << SeatPrice.new(r)
    }
    result
  end
  
  def combine(&block)
    instance_eval &block
  end
  
end

#Query.new.combine do
#  version
#  listAirlines
#  listAirports
#end
