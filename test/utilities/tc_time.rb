require "test/unit"

require "Util"
require "utilities/Time"

class TimeTest < Test::Unit::TestCase
  
  def setup
    @timeStr1 = "12:54"
    @timeStr2 = "03:22"
    @timeStr3 = "12:53"
    
    @time1 = TimeM::parseTime @timeStr1
    @time2 = TimeM::parseTime @timeStr2
    @time3 = TimeM::parseTime @timeStr3
    
    @durStr1 = "12:54"
    @durStr2 = "01:00"
    @durStr3 = "24:54"
    
    @dur1 = TimeM::parseDuration @durStr1
    @dur2 = TimeM::parseDuration @durStr2
    @dur3 = TimeM::parseDuration @durStr3
  end
 
  def test_initialize_time
    assert_equal(12, @time1.hours)
    assert_equal(54, @time1.minutes)
    assert_equal(3, @time2.hours)
    assert_equal(22, @time2.minutes)
    assert_equal(12, @time3.hours)
    assert_equal(53, @time3.minutes)
    
    invalids = ["24:00", "23:60", "false"]
    
    invalids.each do |invalid|
      assert_raise(Util::InvalidInputException) {TimeM::parseTime invalid}      
    end
  end
  
  def test_initialize_duration
    assert_equal(12, @dur1.hours)
    assert_equal(54, @dur1.minutes)
    
    assert_equal(1, @dur2.hours)
    assert_equal(00, @dur2.minutes)
    
    assert_equal(24, @dur3.hours)
    assert_equal(54, @dur3.minutes)
    
    assert_raise(Util::InvalidInputException) {TimeM::parseDuration "false"}      
  end
  
  def test_to_s
    assert_equal(@timeStr1, @time1.to_s)
    
    assert_equal(@durStr1, @dur1.to_s)
    assert_equal(@durStr2, @dur2.to_s)
    assert_equal(@durStr3, @dur3.to_s)
    
  end
  
  def test_compare
    assert(@time1 > @time2)
    assert(@time2 < @time1)
    
    assert(@time1 > @time3)
    assert(@time3 < @time1)
    
    assert(@time3 > @time2)
    assert(@time2 < @time3)
    
    assert_equal(@time1, TimeM::parseTime(@timeStr1))
    assert_equal(@time2, TimeM::parseTime(@timeStr2))
    assert_equal(@time3, TimeM::parseTime(@timeStr3))
    
    assert_equal(@time1, TimeM::parseDuration(@timeStr1))
    assert_equal(@time2, TimeM::parseDuration(@timeStr2))
    assert_equal(@time3, TimeM::parseDuration(@timeStr3))
    
    assert_not_equal(@time1, @time2)
    assert_not_equal(@time3, @time2)
    assert_not_equal(@time2, TimeM::parseTime("22:03"))
  end
 
end
