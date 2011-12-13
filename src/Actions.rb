require 'AbstractQuery'
require 'LastResort'
require 'Util'
require 'utilities/Booking'


class Actions < AbstractQuery
   
  def initialize
    super
  end

    def hold(date, flightnumber, klasse, gender, firstname, surname)
      holds = []     
        (@telnet.query "H"
          + (Util::lengthCheck date, 10)
      + (Util::lengthCheck fligthnumber, 6)
      + (Util::lengthCheck klasse, 1)
      + (Util::lengthCheck gender, 1)
      + (Util::stringValidate firstname, 15)
      + (Util::stringValidate surname, 20)).each { |h|
        if succes? h
          holds << Holding.new(h)
        elsif (h include? "FN") then raise "No seat available in specified category" 
        end
      }
      holds
  end
   
    def book(code)
      booking = []
    (@telnet.query "B" + (Util::lengthCheck code, 32)).each { |r|
      if succes? r
      booking << Booking.new(r)
        elsif (r include? "FN") then raise "No booking available"
        elsif (r include? "FA") then raise "Seat already booked"  
        end 
    }
    booking
    end

  def cancel(code)
    (@telnet.query "X" + (Util::lengthCheck code, 32)).each { |c|
      if succes?
        elsif (c include? "FN") then raise "Invalid booking code"
        elsif (c include? "FA") then raise "Booking is older than 24h and can't be cancelled"  
        end 
    }
  end

  def query(code)
    booking = []
    (@telnet.query "Q" + (Util::lengthCheck code, 32)).each { |r|
      if succes? r
      booking << Booking.new(r)
      elsif (r include? "FN") then raise "No holding or booking"
      end 
    }
    booking
  end
 
  def succes?(output)
    (output include? "S") ? true : false
  end
 
  # The chain of command can be extended by overriding or monkey patching this
  # method to insert any other class.
  # The extendor is responsible for proper handling of
  # non-existing classes then.
  def delegate
    LastResort.new
  end

end