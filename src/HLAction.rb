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
  
  def hold_multi(NumberOfPersons,NumberOfFlights,klasse,PersonsThenFlights)
    
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

  def book_multi(*booking_code)
    codes = []
    booking_code.each do |bc|
      codes << BookingCode.new(bc)
    end
    books(codes)
  end
  alias :query_book_multi :book_multi

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

  def query_multi(*booking_code)
    codes = []
    booking_code.each do |bc|
      codes << BookingCode.new(bc)
    end
    queries(codes)
  end
  alias :query_query_multi :query_multi

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

  def cancel_multi(*booking_code)
    codes = []
    booking_code.each do |bc|
      codes << BookingCode.new(bc)
    end
    cancelall(codes)
  end
  alias :query_cancel_multi :cancel_multi

  def cancelall(booking_code)
    booking_code.each do|h|
      begin
        @actions.cancel(h.code)
      rescue
      end
    end
  end

  def delegate
    LastResort.new
  end


end


