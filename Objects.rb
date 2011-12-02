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
    input =~ /(\S{3})/
    @code = Code.new($&)
    @city = /[A-Za-z ]{20}/.match $'
    @country = /[A-Za-z ]{20}/.match $'
  end
  
    def to_s
    return ((@code.to_s) +" "+(@city.to_s) +" "+(@country.to_s))
  end
  
end

class Time
  def initialize(input)
    input = Util.new.LengthCheck(input,5)
    @hour = input[0,2]
    @minute = input[3,2]
  end
  
  def to_s
    return ((@hour.to_s) +":"+(@minute.to_s))
  end
  
end

class Connection
  
  def initialize(input)
    input = Util.new.LengthCheck(input,16)
    @flightnr = input[0,6]
    @deptime = Time.new(input[6,5])
    @duration = Time.new(input[11,5])     
  end

  def getDate
    return @date
  end

  def getFlightNr
    return @flightnr
  end

  def setDate(date)
    @date = date
  end
  
  def setDeparture(dep)
    @departure = dep
  end

  def setArrival(ar)
    @arrival = ar
  end  
    def to_s
      return ((@date.to_s)+" "+(@departure.to_s)+" "+(@arrival.to_s)+" "+(@flightnr.to_s)+" "+(@deptime.to_s) +" "+(@duration.to_s))
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
    @year = input[0,4]
    @month = input[5,2]
    @day = input[8,2]
  end
  
  def to_s
    return ((@year.to_s) +"-"+(@month.to_s)+"-"+(@day.to_s))
  end
  
end

class Person
  
  def initialize(input)
    input = Util.new.LengthCheck(input,36)
    @gender = input[0,1]
    @firstname = input[1,15]
    @surname = input[16,20]    
  end
  
    def to_s
      return ((@gender.to_s)+" "+(@firstname.to_s)+" "+(@surname.to_s))
    end
  
end

class Booking
  
  def initialize(input)
    input = Util.new.LengthCheck(input,69)
    @status = input[0,1]
    @date = input[1,10]
    @time = Time.new(input[11,5])
    @duration = Time.new(input[16,5])
    @flightnr = input[21,6]
    @klasse = input[27,1]
    @person = Person.new(input[28,36])
    @price = input[64,5]   
  end
  
      def to_s
      return ((@status.to_s)+" "+(@date.to_s)+" "+(@time.to_s)+" "+(@duration.to_s)+" "+(@flightnr.to_s)+" "+(@klasse.to_s)+" "+(@person.to_s)+" "+(@price.to_s))
    end
  
end

class SeatPrice
  
  def initialize(input)
    input = Util.new.LengthCheck(input,8)
    @seats = input[0,4]
    @price = input[4,4]
  end
  
  def to_s
    return ((@seats.to_s)+" "+(@price.to_s))
  end
    
end
