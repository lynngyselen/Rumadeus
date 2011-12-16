require "test/unit"
require "date"

require "utilities/Connection"
require "utilities/Time"

class ConnectionTest < Test::Unit::TestCase
 
  def setup
    @flightcode = "AFR001"
    @deptime = "19:54"
    @duration = "12:38"
    @from = "BRU"
    @to = "AFR"
    @date = "2012-01-12"
    
    @parsedDeptime = TimeM::parseTime @deptime
    @parsedDuration = TimeM::parseDuration @duration
    @parsedDate = Date.parse @date
    
    @conn = Connection.new("#{@flightcode}#{@deptime}#{@duration}",
      @from, @to, @date)
  end
 
  def test_initialize
    assert_equal(@flightcode, @conn.flightcode)
    assert_equal(@parsedDeptime, @conn.deptime)
    assert_equal(@parsedDuration, @conn.duration)
    assert_equal(@from, @conn.from)
    assert_equal(@to, @conn.to)
    assert_equal(@parsedDate, @conn.date)
  end
  
  def test_to_s
    str = "#{@parsedDate.to_s} #{@from.to_s} #{@to.to_s} #{@flightcode}" +
      " #{@parsedDeptime.to_s} #{@parsedDuration.to_s}"
    assert_equal(str, @conn.to_s)
  end
  
  def test_arrival_time
    expected = (DateTime.parse "2012-01-13 08:32")
    assert_equal(expected, @conn.arrival_time)
  end
 
end
