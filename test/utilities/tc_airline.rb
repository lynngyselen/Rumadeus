require "test/unit"

require "utilities/Airline"

class AirlineTest < Test::Unit::TestCase

  def setup
    @code = "BRU"
    @name = "Brussels Airport"
    @al = Airline.new("#{@code}#{@name}")
  end
 
  def test_initialize
    assert_equal(@code, @al.code)
    assert_equal(@name, @al.name)
  end
  
  def test_to_s
    assert_equal("#{@code} #{@name}", @al.to_s)
  end
 
end
