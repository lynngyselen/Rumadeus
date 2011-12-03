require 'Telnet'
require 'Objects'

class Query
  
  def version
    Telnet.new.query "V"
  end
  
  def listAirlines
    result = []
    (Telnet.new.query "A").each { |r|
      result << Airline.new(r)
    }
    return result
  end
  
  def listAirports
    result = []
    (Telnet.new.query "P").each { |r|
      result << Airport.new(r)
    }
    return result
  end
  
  def listDestinations(airport)
    result = []
    (Telnet.new.query "D" + airport).each { |r|
      result << Code.new(r)
    }
    return result
    
  end
  
  def listConnections(date,source, destination)
    result = []
    (Telnet.new.query "C" + source + destination + date).each { |r|
      con = Connection.new(r)
      con.setDeparture(source)
      con.setArrival(destination)
      con.setDate(Date.new(date))
      result << con
    }
    return result
  end
  
  def listLocations(flight)
    Telnet.new.query "F" + flight
  end
  
  def listFlightDays(flight)
    Telnet.new.query "W" + flight 
  end
  
  def listSeats(date, flight, type)
    result = []
    (Telnet.new.query "S" + date.to_s + flight + type).each { |r|
      result << SeatPrice.new(r)
    }
    return result
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
