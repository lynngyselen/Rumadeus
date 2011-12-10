require "test/unit"
require "date"

require "utilities/Booking"
require "utilities/Time"
require "utilities/Person"

class BookingTest < Test::Unit::TestCase

  def setup
    @status = "S"
    @date = "2011-11-06"
    @time = "22:54"
    @duration = "02:34"
    @flightcode = "AFR001"
    @class = "B"
    @gender = "F"
    @firstname = "long_first_name"
    @surname = "even_longer_surname_"
    @price = 99996
    
    @parsedDate = Date.parse @date
    @parsedTime = TimeM::parseTime @time
    @parsedDuration = TimeM::parseDuration @duration
    @person = Person.new "#{@gender}#{@firstname}#{@surname}"
    
    @booking = Booking.new "#{@status}#{@date}#{@time}#{@duration}" +
      "#{@flightcode}#{@class}#{@gender}#{@firstname}#{@surname}#{@price.to_s}"
  end
 
  def test_initialize
    assert_equal(@status, @booking.status)
    assert_equal(@parsedDate, @booking.date)
    assert_equal(@parsedTime, @booking.time)
    assert_equal(@parsedDuration, @booking.duration)
    assert_equal(@flightcode, @booking.flightcode)
    assert_equal(@class, @booking.class)
    assert_equal(@person, @booking.person)
    assert_equal(@price, @booking.price)
  end
  
  def test_to_s
    str = "#{@status} #{@parsedDate.to_s} #{@parsedTime.to_s} " +
      "#{@parsedDuration.to_s} #{@flightcode} #{@class} #{@person.to_s} " +
      "#{@price.to_s}"
    assert_equal(str, @booking.to_s)
  end
 
end
