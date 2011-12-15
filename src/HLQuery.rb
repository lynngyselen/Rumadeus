# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'AbstractQuery'
require 'Query'
require 'Action'
require 'utilities/Path'

# Add fold methods to Array
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

class HLQuery < AbstractQuery
  
  def initialize
    @query = Query.new
    @action = Actions.new
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
  alias :query_multihop :multihop
  
  def bestprice(date, source, destination, type)
    result = []
    @query.listConnections(date, source, destination).each { |c|
      result << @query.listSeats(c.date.to_s, c.flightcode, type)
    }
    result.min || []
  end
  alias :query_best_price :bestprice

  
  def shortestWithStops(date, source, destination, stops)
    result = []
    paths = withStops(source, destination, stops)
    paths.each do |p|
      t = shortestMultiple(date, p)
      result << t
    end
    result.min
  end
  alias :query_shortest_with_stops :shortestWithStops
  
  def shortestMultiple(date, list)
    dt = date
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
  alias :query_shortest_multiple :shortestMultiple
  
  def shortestTwo(date, source, destination)
    result = []
    oridate = DateTime.parse date.to_s 
    for i in 0 .. 6
      result |= @query.listConnections(date.to_date.to_s, source, destination)
      date += 1
    end
    tmp = []
    result.each{ |r| 
      dt = DateTime.parse("#{r.date.to_s} #{r.deptime.to_s}")
      if(dt > oridate)
        tmp << r
      end
    }
    
    find_best_connection tmp
  end
  alias :query_shortest_two :shortestTwo
  
  def find_best_connection conns
    conns.fold nil do |acc, conn|
      better_connection?(conn, acc) ? conn : acc 
    end
  end
  
  def better_connection? (c1, c2)
    if c2.nil?
      has_seats c1
    elsif has_seats c1
      c1.arrival_time < c2.arrival_time
    else
      false
    end
  end
  
  def has_seats conn
    true
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
  alias :query_with_stops :withStops
  
  def hasConnection(source, destination)
    not @query.listDestinations(source).index(Code.new(destination)).nil?
  end
  
  def enough_seats?(number_of_seats, date, flightnumber, klasse)
    seatPrices = @query.get_seats_safely(date, flightnumber, klasse)
    availableSeats = seatPrices.empty? ? 0 : seatPrices[0].seats
    availableSeats >= number_of_seats ? true : false
  end
  alias :query_enough_seats? :enough_seats?
  
  def delegate
    Action.new
  end
  
end
