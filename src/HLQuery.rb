# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'Query'

class HLQuery
  
  # return list of possibilities for each hop
  def multihop(date, source, destination, *destinations)
    result = []
    result << Query.new.listConnections(date, source, destination)
    
    tmpSrc = destination
    destinations.each { |d|
      result << Query.new.listConnections(date, tmpSrc, d)
      tmpSrc = d
    }

    result
  end
  
  def bestprice(date, source, destination, type)
    result = []
    (Query.new.listConnections(date, source, destination)).each { |c|
      result << Query.new.listSeats(c.date, c.flightNr, type)
    }
    result    
  end
  
end

#puts (HLQuery.new.multihop "2012-01-30", "AMS", "CDG", "VIE")

puts (HLQuery.new.bestprice "2012-01-30","CDG", "VIE","E")
