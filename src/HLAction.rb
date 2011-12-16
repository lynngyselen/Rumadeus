require 'Util'
require 'Action'
require 'utilities/BookingCode'
require 'Query'
require 'AbstractQuery'
require 'LastResort'
require 'HLQuery'

class HLAction < AbstractQuery
  
  def initialize
    @actions = Action.new
  end
  
  
  
  def holds(persons,klasse,path)
    holds = []
    begin
      persons.each do |p|
        path.connections.each do |c|
          holds |= @actions.hold(c.date.to_s,c.flightcode.to_s,klasse,p.gender,p.firstname,p.surname)        
        end
      end
    rescue
      begin
        cancelall(holds)
      rescue
      end
      raise Util::ReservationError, "Not everything was put on hold" 
    end
    holds
   end  


  def books(holds)
    books = []
    holds.each do |h|
      begin
        books |= @actions.book(h.code)
      rescue
        begin
          cancelall(holds)
        rescue
        end
        raise Util::ReservationError, "Not everything was booked" 
      end
    end
    books
  end
   alias :query_books :books

  def queries(books)
    result =[]
    books.each do|b|
      begin
        result.concat(@actions.query(b.code))
      rescue
      end
    end
    result
  end
  alias :query_queries :queries

  def cancelall(booking_code)
    booking_code.each do|h|
      begin
        @actions.cancel(h.code)
      rescue
      end
    end
  end
  alias :query_cancelall :cancelall

  def delegate
    LastResort.new
  end


end


