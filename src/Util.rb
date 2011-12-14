module Util
  
  QUERY_ID = "query_"

  def Util::stringValidate(str, length)
    if str.length > length
      raise InvalidInputException, "input too long..."
    else
      str + (" " * (length - str.length))
    end
  end

  def Util::lengthCheck(str, size)
    if str.length != size
      raise InvalidInputException, "input error: the string \"#{str}\" " +
        "has size #{str.length} instead of #{size}."
    end
    str
  end
  
  def Util::remove_query name
    if name.start_with? QUERY_ID
      name[QUERY_ID.length..name.length-1]
    else
      name
    end
  end
  
  def Util::add_query name
    QUERY_ID + name
  end
  
  class InvalidInputException < StandardError; end
  class ReservationError < StandardError; end
  
  class ServerError < StandardError
    
    attr_reader :cause
    
    ERRIM = "ERRIM"
    ERREC = "ERREC"
    ERRNR = "ERRNR"
    ERRXX = "ERRXX"
    
    def initialize errorMsg
      @cause = init_cause errorMsg
    end
    
    def init_cause errorMsg
      case errorMsg
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
