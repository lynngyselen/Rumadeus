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
  
  def Util::method_parameters object
    result = []
    object.methods.each do |method|
      if method_start_with_query?(method, object)
        result << format_method(method, object)
      end
    end
    result
  end
  
  def Util::format_method (method, object)
    str = remove_query method.to_s.rstrip
    params = parameters(object, method).rstrip
    if not params.empty?
      str += " : #{params}"
    end
    str.rstrip
  end
  
  def Util::method_start_with_query? (method, object)
    (object.class.instance_method method).name.to_s.start_with? QUERY_ID
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
  
  def Util::parameters(object, method)
    object.class.instance_method(method).parameters.map { |param|
      transform_parameter param
    }.join(" ")
  end
  
  def Util::transform_parameter param
    if param[0] == :req
      param[1].to_s
    elsif param[0] == :opt
      "(#{param[1].to_s})"
    end
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
