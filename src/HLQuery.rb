# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'Query'

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
    (@query.listConnections(date, source, destination)).each { |c|
      result << @query.listSeats(c.date, c.flightnr, type)
    }
    result    
  end
  
end
