require 'Util'
require 'Actions'
require 'utilities/BookingCode'
require 'Query'
require 'AbstractQuery'
require 'LastResort'

class MultipleBookings < AbstractQuery
  
  def initialize
    @actions = Actions.new
  end
  
  
  
  def groupBooking(nbofseats, date, flightnumber, klasse, persons)
    holds = []
    if enough_seats?(nbofseats, date, flightnumber, klasse)
      begin
        holds = holdall(date, flightnumber, klasse, persons)
      rescue => e
        e.inspect
      end
      bookall holds
    end
  end
  

  def holdall(date, flightnumber, klasse, persons)
    holds = []
    persons.each { |p|
      begin
        holds << @actions.hold(date, flightnumber, klasse, p.gender,
          p.firstname, p.surname)
      rescue
        p "Cancelall holds"
        cancelall holds
        raise  Util::ReservationError, "No reservations were made"
      end
    }
    holds
  end

  def bookall(holds)
    books = []
    holds.each {|h|
      begin
        books << @actions.book(h.code)
      rescue
        p "Not all reservations are booked"
      end
    }
    books
  end

  def cancelall(holds)
    holds.each {|h|
      begin
        @actions.cancel(h.code)
      rescue
        p "Not all holdings were cancelled"
      end
    }
  end

  def enough_seats?(numberofseats, date, flightnumber, klasse)
    query = Query.new
    seatPrices = query.get_seats_safely(date, flightnumber, klasse)
    availableSeats = seatPrices.empty? ? 0 : seatPrices[0].seats
    availableSeats >= numberofseats ? true : false
  end

  def delegate
    LastResort.new
  end


end
