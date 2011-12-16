require 'Util'
require 'Actions'
require 'utilities/BookingCode'
require 'Query'
require 'AbstractQuery'
require 'LastResort'
require 'HLQuery'

class HLAction < AbstractQuery
  
  def initialize
    @actions = Actions.new
  end
  
  def holds(persons,klasse,path)
    holds = []
    p path
    p path.connections
    begin
      persons.each do |p|
        path.connections.each do |c|
          holds << @actions.hold(c.date.to_s,c.flightcode.to_s,klasse,p.gender,p.firstname,p.surname)        
        end
      end
    rescue => e
      p e
      begin
        cancelall(holds)
      rescue
      end
      p "No holds were made"
    end
    p holds
    holds
   end  
  alias :query_holds :holds

  def books(holds)
    books = []
    holds.each do |h|
      begin
        books << @actions.book(h.code)
      rescue => e
        p e
      end
    end
    books
  end
   alias :query_books :books

  def queries(books)
    result =[]
    books.each do|b|
      begin
        result <<@actions.query(b.code)
      rescue => e
        p e
      end
    end
  end
  alias :query_queries :queries

  def cancelall(booking_code)
    p booking_code
    booking_code.each do|h|
      begin
        @actions.cancel(h.code)
      rescue => e
        p e
      end
    end
  end
  alias :query_cancelall :cancelall

  def delegate
    LastResort.new
  end


end


