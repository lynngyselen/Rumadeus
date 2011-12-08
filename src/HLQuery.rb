# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'Query'
require 'Actions'

class HLQuery
  
  def initialize
    @query = Query.new
  end
  
  # return list of possibilities for each hop
  def multihop(date, source, *destinations)
    result = []
    tmpSrc = source
    
    destinations.each do |d|
      result << @query.listConnections(date, tmpSrc, d)
      tmpSrc = d
    end
    
    result
  end
  
  def bestprice(date, source, destination, type)
    result = []
    @query.listConnections(date, source, destination).each { |c|
      result << @query.listSeats(c.date, c.flightnr, type)
    }
    result.min    
  end
  
  def helper(source, destination, stops)
    result = []
    if(stops == 0)
      if(not hasConnection(source, destination))
        result = [source, destination]
      end
    else
      (@query.listDestinations(source)).each { |c|
        begin
          tmp = helper(c.to_s, destination, stops-1)
          tmp.each { |d|
            result << ([source] | d)
          }
        rescue => e
          result << ([source] | tmp)
        end
      }
    end
    result
  end
  
  def hasConnection(source, destination)
    @query.listDestinations(source).index(Code.new(destination)).nil?
  end

  def withStops(date,source,destination,stops)
    result = []
    helper(source, destination, stops).each { |h|
      str=""
      (3..h.length).each do |i|
        str += h[i-1]
      end
      if (str != "")
        result << multihop(date, h[0], h[1], str)
      else
        result << multihop(date, h[0], h[1])
      end
     }
     result 
  end
  
  def method_missing *args
    Actions.new.send *args
  end
  
end
