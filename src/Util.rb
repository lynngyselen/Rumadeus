module Util

  def Util::stringValidate(str, max)
    if str.length > max
      raise InvalidInputException, "input too long..."
    else
      for i in 1 .. (max - str.length)
        str += " "
      end
    end
    str
  end

  def Util::lengthCheck(str, size)
    if str.length != size
      raise InvalidInputException, "input error: the string \"#{str}\" "+
        "has size #{str.length} instead of #{size}."
    end
    str
  end
  
  class InvalidInputException < StandardError; end
  
  class ServerError < StandardError
    
    attr_reader :errorMsg
    
    ERRIM = "ERRIM"
    ERREC = "ERREC"
    ERRNR = "ERRNR"
    ERRXX = "ERRXX"
    
    def initialize errorMsg
      @errorMsg = errorMsg
    end
    
    def cause
      case @errorMsg
        when ERRIM
          "#{ERRIM}: Ill formatted message."
        when ERREC
          "#{ERREC}: Empty command."
        when ERRNR
          "#{ERRNR}: No results."
        when ERRXX
          "#{ERRXX}: Something went wrong badly..."
        else
          "Unknown error code."
      end
    end
  end
  
end
