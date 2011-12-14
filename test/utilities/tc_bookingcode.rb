require "test/unit"

require "Util"
require "utilities/BookingCode"

class BookingCodeTest < Test::Unit::TestCase

  def test_initialize_success
    code = "Se7f2a02364ff4bd7065fdde2306733ff"
    bc = BookingCode.new code
    assert_equal(code[1..33], bc.code)
    assert_equal(code, bc.to_s)
  end
  
  def test_initialize_too_short
    code = "Se7f2a02364ff4bd7065fdde2306733f"
    assert_raise(Util::InvalidInputException) {BookingCode.new code}
  end
  
  def test_initialize_too_long
    code = "Se7f2a02364ff4bd7065fdde2306733ff_"
    assert_raise(Util::InvalidInputException) {BookingCode.new code}
  end
 
end
