module Util

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
      result << "#{method.to_s} #{parameters(object, method)}"
    end
    result
  end
  
  def Util::parameters(object, method)
    object.class.instance_method(method).parameters.map { |param|
      transform_parameter param
    }.join(" ")
  end
  
  def Util::transform_parameter param
    if (param.at 0) == :req
      (param.at 1).to_s
    elsif (param.at 0) == :opt
      "(#{(param.at 1).to_s})"
    end
  end
  
  class InvalidInputException < StandardError; end
  
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
