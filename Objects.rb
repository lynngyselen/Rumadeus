
class Code

  def initialize(code)
    @code = Util.new.LengthCheck(code,3)
  end	

end

class Airline
  
  def initialize(input)
    input = Util.new.LengthCheck(input,33)
    @code = Code.new(input[0,2])
    @name = input[3,32]
  end
end

class Airport
  
  def initialize(input)
    input = Util.new.LengthCheck(input,43)
    @code = Code.new(input[0,2])
    @city = input[3,22]
    @country = input[23,42]    
  end
end

class Time
  def initialize(input)
    input = Util.new.LengthCheck(input,4)
    @hour = input[0,1]
    @minute = input[2,3]
  end
end

class Connection
  
  def initialize(input)
    input = Util.new.LengthCheck(input,16)
    @flightnr = input[0,5]
    @deptime = input[6,10]
    @duration = input[11,15]     
  end
end





