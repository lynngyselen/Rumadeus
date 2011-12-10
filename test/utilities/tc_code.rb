require "test/unit"

require "Util"
require "utilities/Code"

class CodeTest < Test::Unit::TestCase
 
  def test_initialize_success
    c = "AFR"
    code = Code.new c
    assert_equal(c, code.code)
    assert_equal(c, code.to_s)
  end
  
  def test_initialize_too_short
    code = "AF"
    assert_raise(Util::InvalidInputException) {Code.new code}
  end
  
  def test_initialize_too_long
    code = "AFR "
    assert_raise(Util::InvalidInputException) {Code.new code}
  end
  
  def test_equal
    assert_equal(Code.new("AFR"), Code.new("AFR"))
    assert_not_equal(Code.new("BRU"), Code.new("AFR"))
  end
 
end
