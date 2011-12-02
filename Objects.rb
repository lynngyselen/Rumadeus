require 'Util'

class Code

  def initialize(code)
    @code = Util.new.LengthCheck(code,3)
  end	

  def to_s
    @code
  end

end

class Airline
  
  def initialize(input)
    input =~ /\S{3}/
    @code = Code.new($&)
    @name = $'
  end
  
  def to_s
    return ((@code.to_s) +" "+(@name.to_s))
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
    input = Util.new.LengthCheck(input,5)
    @hour = input[0,1]
    @minute = input[3,4]
  end
end

class Connection
  
  def initialize(input)
    input = Util.new.LengthCheck(input,16)
    @flightnr = input[0,5]
    @deptime = Time.new(input[6,10])
    @duration = Time.new(input[11,15])     
  end
end

class BookingCode
  
  def initialize(input)
    @code = Util.new.LengthCheck(input,32)
  end
end

class Date
  
  def initialize(input)
    input = Util.new.LengthCheck(input,10)
    @year = input[0,3]
    @month = input[5,6]
    @day = input[8,9]
  end
end

class Person
  
  def initialize(input)
    input = Util.new.LengthCheck(input,36)
    @gender = input[0]
    @firstname = input[1,15]
    @surname = input[16,35]    
  end
end

class Booking
  
  def initialize(input)
    input = Util.new.LengthCheck(input,68)
    @date = input[0,9]
    @time = Time.new(input[10,14])
    @duration = Time.new(input[15,19])
    @flightnr = input[20,25]
    @klasse = input[26]
    @person = input[27,63]
    @price = input[64,67]   
  end
end
