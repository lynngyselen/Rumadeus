# hold multihop BRU, TEL, BKK, ...
# book multihop FlightNumber(BRU->TEL), Flightnumber2(TEL->BKK), ...
# query multihop BRU, TEL, ...
# cancel multihop BRU, TEL, ...

require 'AbstractQuery'
require 'Query'
require 'Actions'
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
  
  def holdMulti(connections,klasse,person)
    holds=[]
    connections.each do |c|
      begin
      holds << @action.hold(c.date, c.flightcode, klasse, person.gender, 
        person.firstname, person.surname)
      rescue
        cancelMulti(holds)
      end
    end
    holds
  end
  alias :query_hold_multi :holdMulti
  
  def bookMulti(holds)
    bookings = []
    begin
    holds.each do |b|
      bookings << @action.book(b)
    end
    rescue
    end
    bookings
  end
  alias :query_book_multi :bookMulti
  
  def cancelMulti(holds)
    begin
      holds.each do |b|
        @action.cancel(b)
      end
    rescue    
    end
  end
  alias :query_cancel_multi :cancelMulti
  
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
    
    tmp.fold tmp[0] do |acc, conn|
      acc.arrival_time > conn.arrival_time ? conn : acc 
    end
  end
  alias :query_shortest_two :shortestTwo
  
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
  
  def delegate
    Actions.new
  end
  
end
