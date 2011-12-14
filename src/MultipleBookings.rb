require 'Util'
require 'Actions'
require 'utilities/BookingCode'
require 'Query'

class MultipleBookings
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
    action = Actions.new
    persons.each { |p|
      begin
        p persons.size
        holds << action.hold(date, flightnumber, klasse, p.gender, p.firstname, p.surname)
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
    action = Actions.new
    holds.each {|h|
      begin
        books << action.book(h.code)
      rescue
      p "Not all reservations are booked"
      end
    }
    books
  end

  def cancelall(holds)
    action = Actions.new
    holds.each {|h|
      begin
        action.cancel(h.code)
      rescue
      p "Not all holdings were cancelled"
      end
    }
  end

  def enough_seats?(numberofseats, date, flightnumber, klasse)
    query = Query.new
    seatPrices = query.get_seats_safely(date, flightnumber, klasse)
    seatPrices.empty? ? [] : availableSeats = seatPrices[0].seats
    availableSeats >= numberofseats ? true : false
  end

end
