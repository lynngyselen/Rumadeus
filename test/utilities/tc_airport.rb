require "test/unit"

require "utilities/Airport"
require "utilities/Code"

class AirportTest < Test::Unit::TestCase

  def setup
    @code = "BRU"
    @city = "Brussels            "
    @country = "Belgium             "
    @ap = Airport.new "#{@code}#{@city}#{@country}"
  end
 
  def test_initialize
    assert_equal(Code.new(@code), @ap.code)
    assert_equal(@city, @ap.city)
    assert_equal(@country, @ap.country)
  end
  
  def test_to_s
    assert_equal("#{@code.to_s} #{@city} #{@country}", @ap.to_s)
  end
 
end
