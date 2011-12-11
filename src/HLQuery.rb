# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'Query'
require 'Actions'
require 'utilities/Path'

class Array
  def foldl(accum, &block)
    each {|value| accum = yield(accum, value)}
    return accum
  end

  def foldr(accum, &block)
    reverse.foldl(accum, &block)
  end

  alias fold :foldl
end

class HLQuery
  
  def initialize
    @query = Query.new
    @actions = Actions.new
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
      result << @query.listSeats(c.date, c.flightcode, type)
    }
    result.min || []
  end
  
  def shortestWithStops(date, source, destination, stops)
    result = []
    paths = withStops(source, destination, stops)
    paths.each do |p|
      t = shortestMultiple(date, p)
      result << t
    end
    result.min
  end      
  
  def shortestMultiple(date, list)
    DateTime dt = date
    result = []
    for i in 0 .. (list.size-2)
      tmp =  shortestTwo(dt, list[i], list[i+1])
      if not tmp.nil?
        dt = tmp.arrival_time
        result << tmp
      end
    end
    path = Path.new(date, result)
  end
  
  def shortestTwo(date, source, destination)
    result = []
    oridate = DateTime.parse date.to_s 
    for i in 0 .. 6
      result |= @query.listConnections((Date.parse(date.year.to_s+"-"+date.month.to_s+"-"+date.day.to_s)).to_s,source,destination)
      date +=1
    end
    tmp = []
    result.each{ |r| 
      dt = DateTime.parse("#{r.date.to_s} #{r.deptime.to_s}")
      if(dt > oridate)
        tmp << r
      end
    }
    
    tmp.fold(tmp.at 0) do |acc, conn|
      if acc.arrival_time > conn.arrival_time
        conn
      else
        acc
      end 
    end
  end
  
  def withStops(source, destination, stops)
    result = []
    if(source == destination)
      result =[source]
    elsif(stops == 0)
      if(hasConnection(source, destination))
        result = [source, destination]
      end
    else
      (@query.listDestinations(source)).each { |c|
          tmp = withStops(c.to_s, destination, stops-1)
        begin
          tmp.each { |d|
            result << ([source].concat(d))
          }
        rescue => e
          result << ([source].concat(tmp))
        end
      }
    end
    result
  end
  
  def hasConnection(source, destination)
    not @query.listDestinations(source).index(Code.new(destination)).nil?
  end
  
  def method_missing *args
    @actions.send *args
  end
  
end
