
class Code

  def initialize(code)
    @code = Util.new.LengthCheck(code,3)
  end	

end

class Airline
  
  def initialize(input)
    input = Util.new.LengthCheck(input,33)
    @code = Code.new(input[0,2])
    @name = input.sub[3,32]
  end
end

class Airport
  
  def initialize(input)
    input = Util.new.LengthCheck(input,43)
    @code = Code.new(input[0,2])
    @city = input.sub[3,22]
    @country = input.sub[23,42]    
  end
end





