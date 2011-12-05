class SeatPrice
  include Comparable
  def initialize(input)
    input =~ /(\d{4})(\d{4})/
    @seats = $1
    @price = $2
  end
  
    def <=>(other)
    if self.size < other.getPrice
      -1
    elsif self.size > other.getPrice
      1
    else
      0
    end
  end
  
  def getPrice
    @price
  end
  
  def to_s
    (@seats.to_s) + " " + (@price.to_s)
  end
    
end
