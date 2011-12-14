require "test/unit"

require "Util"
require "utilities/BookingCode"

class BookingCodeTest < Test::Unit::TestCase
  
  def setup
    @code = "e7f2a02364ff4bd7065fdde2306733ff"
    @status_code = "S#{@code}"
  end

  def test_initialize_success
    bc = BookingCode.new @status_code
    assert_equal(@code, bc.code)
    assert_equal("Booking, code: #{@code}", bc.to_s)
  end
  
  def test_initialize_too_short
    code = @status_code.chop
    assert_raise(Util::InvalidInputException) {
      BookingCode.new code
    }
  end
  
  def test_initialize_too_long
    code = "#{@status_code}_"
    assert_raise(Util::InvalidInputException) {
      BookingCode.new code
    }
  end
end
