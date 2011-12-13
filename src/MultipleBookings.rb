class MultipleBookings
require 'Actions'

 
  def groupBooking(date, flightnumber, klasse, persons)
        nbofbookings = persons.size
        holds = []
        if enough_seats? (nbofbookings, date, flightnumber, klasse)
        begin 
          holds = holdall(date, flightnumber, klasse, persons)
        rescue => e
          p e
        end  
        begin 
          bookall holds
        rescue => e
          p e  
        end
      
  end
 
  def holdall(date, flightnumber, klasse, persons)
    holds = []
    action = Actions.new
    persons.each { |p|
      begin
           output = action.hold(date, flightnumber, klasse, p.gender, p.firstname, p.surname)
           holds << Holding.new(output)
      rescue
           cancelall holds
      raise  "No reservations were made"
      end
      }
      holds  
  end
 
  def bookall(holds)
    books = []
    action = Actions.new
    holds.each {|h|
    begin 
      output = action.book(h)
      books << Booking.new(output)
    rescue
       # return books
        raise "Not all reservations are booked"
    end 
    }
    books
  end
 
 
  def cancelall(holds)
    action = Actions.new
    holds.each {|h|
    begin 
      action.cancel(h)
    rescue     
    end
      }
  end
 
    def enough_seats? (numberofseats, date, flightnumber, klasse)
    seatPrices = @query.get_seats_safely(date, flightnumber, klasse)
    seatPrices.empty? ? [] : availableSeats = seatPrices[0].seats
    availableSeats >= numberofseats ? true : false
  end