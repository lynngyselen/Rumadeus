require 'Telnet'

class Query
  def version
    Telnet.new.query "V"
  end
  
  def listAirlines
    Telnet.new.query "A"
  end
  
  def listAirports
    Telnet.new.query "P"
  end
  
  def listDestinations(airport)
    Telnet.new.query "D" + airport
  end
  
  def listConnections(date, source, destination)
    Telnet.new.query "C" + source + destination + date
  end
  
  def listLocations(flight)
    Telnet.new.query "F" + flight
  end
  
  def listFlightDays(flight)
    Telnet.new.query "W" + flight 
  end
  
  def listSeats(date, flight, type)
    Telnet.new.query "S" + date + flight + type
  end
  
  def combine(&block)
    instance_eval &block
  end
  
end

Query.new.combine do
  version
  listAirlines
  listAirports
end

