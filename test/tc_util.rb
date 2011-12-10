require "test/unit"

require "Util"

class UtilTest < Test::Unit::TestCase
  
  def setup
    @str1 = "testStr"
    @str2 = ""
    @str3 = "very_long string" * 15
    @strs = [@str1, @str2, @str3]
  end
 
  def test_string_validate
    @strs.each do |str|
      assert_equal(str, Util::stringValidate(str, str.length))
      assert_equal("#{str} ", Util::stringValidate(str, str.length + 1))
      assert_equal(str + " " * str.length,
          Util::stringValidate(str, str.length * 2))
      assert_raise(Util::InvalidInputException) {
        Util::stringValidate(str, str.length - 1)
      }
    end
  end
  
  def test_length_check
    @strs.each do |str|
      assert_equal(str, Util::lengthCheck(str, str.length))
      [1, -1].each do |incr|
        assert_raise(Util::InvalidInputException) {
          Util::lengthCheck(str, str.length + incr)
        }
      end
    end
  end
  
end
