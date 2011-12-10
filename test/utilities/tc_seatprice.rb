require "test/unit"

require "utilities/SeatPrice"

class SeatPriceTest < Test::Unit::TestCase
 
  def setup
    @seats = 245
    @price = 42573
    
    @seatprice = SeatPrice.new("#{@seats.to_s}#{@price.to_s}")
  end
 
  def test_initialize
    assert_equal(@seats, @seatprice.seats)
    assert_equal(@price, @seatprice.price)
  end
  
  def test_to_s
    str = "#{@seats.to_s} #{@price.to_s}"
    assert_equal(str, @seatprice.to_s)
  end
  
  def test_compare
    bigs = [SeatPrice.new("#{@seats.to_s}#{42574.to_s}"),
            SeatPrice.new("#{246.to_s}#{42574.to_s}")]
    smalls = [SeatPrice.new("#{@seats.to_s}#{42572.to_s}"),
              SeatPrice.new("#{244.to_s}#{42572.to_s}")]
    equals = [SeatPrice.new("#{@seats.to_s}#{@price.to_s}"),
              SeatPrice.new("#{244.to_s}#{@price.to_s}"),
              SeatPrice.new("#{246.to_s}#{@price.to_s}")]
              
    bigs.each do |big|
      assert(big > @seatprice)
    end
    smalls.each do |small|
      assert(small < @seatprice)
    end
    equals.each do |equal|
      assert(equal == @seatprice)
    end
  end
 
end
