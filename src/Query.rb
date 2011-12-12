require 'date'

require 'AbstractQuery'
require 'Util'
require 'HLQuery'
require 'utilities/Airline'
require 'utilities/Airport'
require 'utilities/Code'
require 'utilities/Connection'
require 'utilities/SeatPrice'

class Query < AbstractQuery
  
  def initialize
    super
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
  
  def listConnections(date, source, destination)
    result = []
    (@telnet.query "C" + source + destination + date).each { |r|
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
  
  def listSeats(inDate, flight, type, incrStr = "0")
    result = []
    incr = incrStr.to_i
    (-incr .. incr).each do |i|
      date = (parse_date inDate) + i
      result.concat get_seats_safely(date.to_s, flight, type)
    end
    result
  end
  
  def parse_date date
    begin
      Date.parse date
    rescue ArgumentError
      raise Util::InvalidInputException
    end
  end
  
  def get_seats_safely(date, flight, type)
    result = []
    begin
      (@telnet.query "S" + date + flight + type).each { |r|
        result << SeatPrice.new(r)
      }
    rescue Util::ServerError => error
      handle_server_error_no_errnr error
    end
    result
  end
  
  def handle_server_error_no_errnr error
    case error.cause
      when Util::ServerError::ERRNR
        # NO-OP
      else
        error.cause
    end
  end
  
  def combine(puts = true, &block)
    if block_given?
      out = instance_eval &block
      if puts
        puts out
      end
    end
  end
  
  def delegate
    HLQuery.new
  end
  
end

#Query.new.combine do
#  version
#  listAirlines
#  listAirports
#end
