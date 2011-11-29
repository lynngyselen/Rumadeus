
class Util

  def StringValidate(str,max)
    if(str.length > max)
      raise "input error"
    else
      for i in (1 .. (max - str.length))
        str += " "
      end
    end
    return str
  end

  def LengthCheck(str,size)
    if(str.length != size)
      raise "input error"
    end
    return str
  end  
end
