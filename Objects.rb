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
    input =~ /\w{3}/
    @code = Code.new($&)
    @name = $'
  end
  
  def to_s
    return ((@code.to_s) +" "+(@name.to_s))
  end
  
end

class Airport
  
  def initialize(input)
    input =~ /(\w{3})([A-Za-z ]{20})([A-Za-z ]{20})/
    @code = Code.new($1)
    @city = $2
    @country = $3
  end
  
    def to_s
    return ((@code.to_s) +" "+(@city.to_s) +" "+(@country.to_s))
  end
  
end

class Time
  def initialize(input)
    input =~ /(\d{2})(:)(\d{2})/
    @hour = $1
    @minute = $3
  end
  
  def to_s
    return ((@hour.to_s) +":"+(@minute.to_s))
  end
  
end

class Connection
  
  def initialize(input)
    input =~ /(\w{3}\d{3})([0-9:]{5})([0-9:]{5})/ 
    @flightnr = $1
    @deptime = Time.new($2)
    @duration = Time.new($3)   

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
    input =~ /(\d+)(-)(\d+)(-)(\d+)/
    @year = $1
    @month = $3
    @day = $5
  end
  
  def to_s
    return ((@year.to_s) +"-"+(@month.to_s)+"-"+(@day.to_s))
  end
  
end

class Person
  
  def initialize(input)
    input =~ /([MF])([A-Za-z ]{15})([A-Za-z ]{20})/
    @gender = $1
    @firstname = $2
    @surname = $3  
  end
  
    def to_s
      return ((@gender.to_s)+" "+(@firstname.to_s)+" "+(@surname.to_s))
    end
  
end

class Booking
  
  def initialize(input)
    input =~ /([BH])([0-9-]{10})([0-9:]{5})([0-9:]{5})(\w{3}\d{3})(\w)([A-Za-z ]{36})(\d{5})/
    @status = $1
    @date = Date.new($2)
    @time = Time.new($3)
    @duration = Time.new($4)
    @flightnr = $5
    @klasse = $6
    @person = Person.new($7)
    @price = $8  
  end
      def to_s
      return ((@status.to_s)+" "+(@date.to_s)+" "+(@time.to_s)+" "+(@duration.to_s)+" "+(@flightnr.to_s)+" "+(@klasse.to_s)+" "+(@person.to_s)+" "+(@price.to_s))
    end
  
end

class SeatPrice
  
  def initialize(input)
    input =~ /(\d{4})(\d{4})/
    @seats = $1
    @price = $2
  end
  
  def to_s
    return ((@seats.to_s)+" "+(@price.to_s))
  end
    
end
