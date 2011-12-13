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
  alias :query_version :version
  
  def listAirlines
    result = []
    (@telnet.query "A").each { |r|
      result << Airline.new(r)
    }
    result
  end
  alias :query_list_airlines :listAirlines
  
  def listAirports
    result = []
    (@telnet.query "P").each { |r|
      result << Airport.new(r)
    }
    result
  end
  alias :query_list_airports :listAirports
  
  def listDestinations(airport)
    result = []
    (@telnet.query "D" + airport).each { |r|
      result << Code.new(r)
    }
    result
  end
  alias :query_list_destinations :listDestinations
  
  def listConnections(date, source, destination)
    result = []
    (@telnet.query "C" + source + destination + date).each { |r|
      con = Connection.new(r, source, destination, date)
      result << con
    }
    result
  end
  alias :query_list_connections :listConnections
    
  def listLocations(flight)
    @telnet.query "F" + flight
  end
  alias :query_list_locations :listLocations
  
  def listFlightDays(flight)
    @telnet.query "W" + flight 
  end
  alias :query_list_flightdays :listFlightDays
  
  def listSeats(date, flight, type, incrStr = "0")
    result = []
    incr = incrStr.to_i
    (-incr .. incr).each do |i|
      new_date = (parse_date date.to_s) + i
      result.concat get_seats_safely(new_date.to_s, flight, type)
    end
    result
  end
  alias :query_list_seats :listSeats
  
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
