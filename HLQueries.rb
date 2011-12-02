# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'queries'

class HLQuery
  # return list of possibilities for each hop
  def multihop(date, source, destination1, *otherDestinations)
    result = []
    result << Query.new.listConnections(date,source, destination1)
    
    tmpSrc = destination1
    otherDestinations.each { |d|
      result << Query.new.listConnections(date, tmpSrc, d)
      tmpSrc = d
    }

    return result
  end
    
  def bestprice(date,source,destination,type)
    result = []
    (Query.new.listConnections(date,source, destination)).each{
      |c|
          result |=  Query.new.listSeats(c.getDate,c.getFlightNr,type)
    }
    

    result.sort!
    
    return result[0,1]    
  end
  
  
  def helper(source,destination,stops)
      result =[]
      if(stops==0)
        if(Query.new.listDestinations(source).index(Code.new(destination))!=nil)
          result = [source,destination]
        end
      else
        (Query.new.listDestinations(source)).each{
        |c|
        begin
        tmp =helper(c.to_s,destination,stops-1)
        tmp.each{
          |d|
            result << ([source] | d)
        }
        rescue => e
          result << ([source]|tmp)
        end
          #result << tmp
         }
        
      end
        result
  end

  def withStops(date,source,destination,stops)
      result =[]
      helper(source,destination,stops).each{
        |h|
          str=""
          (3..h.length).each do |i|
            str+=h[i-1]
          end
          if (str !="")
            result << multihop(date,h[0],h[1],str)
          else
            result << multihop(date,h[0],h[1])
          end
      }
     result
      
  end  
  
  
end

#puts (HLQuery.new.multihop "2012-01-30", "CDG", "AMS", "VIE")

#puts (HLQuery.new.bestprice "2012-01-30","CDG", "VIE","E")

#puts (HLQuery.new.withStops "2012-01-30","CDG", "VIE",2)

p HLQuery.new.helper("CDG","VIE",2)

