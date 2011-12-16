require 'Util'
require 'Action'
require 'utilities/BookingCode'
require 'Query'
require 'AbstractQuery'
require 'LastResort'
require 'HLQuery'

class MultipleBookings < AbstractQuery
  
  def initialize
    @actions = Actions.new
  end
  
  def hold_multi_connections(connections, klasse, person)
    holds = []
    connections.each do |c|
      begin
      holds << @action.hold(c.date, c.flightcode, klasse, person.gender, 
        person.firstname, person.surname)
      rescue
        cancel_multi holds
      end
    end
    holds
  end
  alias :query_hold_multi_connections :hold_multi_connections
  
  def hold_multi_persons(date, flightnumber, klasse, persons)
    holds = []
    persons.each { |p|
      begin
        holds << @actions.hold(date, flightnumber, klasse, p.gender,
          p.firstname, p.surname)
      rescue
        p "Cancelall holds"
        cancel_multi holds
        raise  Util::ReservationError, "No reservations were made"
      end
    }
    holds
  end
  alias :query_hold_multi_persons :hold_multi_persons

  def book_multi(*booking_code)
    books = []
    booking_code.each {|h|
      begin
        books << @actions.book(h.code)
      rescue
        p "Not all reservations are booked"
      end
    }
    books
  end
   alias :query_book_multi :book_multi

  def cancel_multi(*booking_code)
    booking_code.each {|h|
      begin
        @actions.cancel(h.code)
      rescue
        p "Not all holdings were cancelled"
      end
    }
  end
  alias :query_cancel_multi :cancel_multi


  def group_booking(number_of_seats, date, flightnumber, klasse, persons)
    holds = []
    hlquery = HLQuery.new
    if hlquery.enough_seats?(number_of_seats, date, flightnumber, klasse)
      begin
        holds = hold_multi(date, flightnumber, klasse, persons)
      rescue => e
        e.inspect
      end
      book_multi holds
    end
  end
  alias :query_group_booking :group_booking


  def delegate
    LastResort.new
  end


end


