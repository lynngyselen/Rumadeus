module Util

  def Util.stringValidate(str, max)
    if(str.length > max)
      raise "input error"
    else
      for i in (1 .. (max - str.length))
        str += " "
      end
    end
    str
  end

  def Util.lengthCheck(str, size)
    if(str.length != size)
      raise "input error: the string \"#{str}\" "+
        "has size #{str.length} " +
        "instead of #{size}."
    end
    str
  end  
end
