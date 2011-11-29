# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'queries'

class HLQuery
  # return list of possibilities for each hop
  def multihop(date, source, destination1, *otherDestinations)
    result = []
    result << Query.new.listConnections(date, source, destination1)
    
    tmpSrc = destination1
    otherDestinations.each { |d|
      result << Query.new.listConnections(date, tmpSrc, d)
      tmpSrc = d
    }

    return result
  end
end

puts (HLQuery.new.multihop "2012-01-30", "AMS", "CDG", "VIE")