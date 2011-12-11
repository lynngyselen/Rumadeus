require 'date'

require 'Telnet'
require 'HLQuery'
require 'utilities/Airline'
require 'utilities/Airport'
require 'utilities/Code'
require 'utilities/Connection'
require 'utilities/SeatPrice'

class Query
  
  def initialize
    @telnet = Telnet.new
    @hlquery = HLQuery.new
  end
  
  def version
    @telnet.query "V"
  end
  
  def listAirlines
    result = []
    (@telnet.query "A" || []).each { |r|
      result << Airline.new(r)
    }
    result
  end
  
  def listAirports
    result = []
    ((@telnet.query "P") || []).each { |r|
      result << Airport.new(r)
    }
    result
  end
  
  def listDestinations(airport)
    result = []
    (@telnet.query "D" + airport || []).each { |r|
      result << Code.new(r)
    }
    result
  end
  
  def listConnections(date, source, destination)
    result = []
    ((@telnet.query "C" + source + destination + date) || []).each { |r|
      con = Connection.new(r, source, destination, date)
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
    (@telnet.query "S" + date.to_s + flight + type || []).each { |r|
      result << SeatPrice.new(r)
    }
    result
  end
  
  def combine(puts = true, &block)
    if block_given?
      out = instance_eval &block
      if puts
        puts out
      end
    end
  end
  
  def method_missing *args
    @hlquery.send *args
  end
  
end

#Query.new.combine do
#  version
#  listAirlines
#  listAirports
#end
