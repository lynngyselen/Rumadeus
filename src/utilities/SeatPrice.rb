class SeatPrice
  
  def initialize(input)
    input =~ /(\d{4})(\d{4})/
    @seats = $1
    @price = $2
  end
  
  def to_s
    (@seats.to_s) + " " + (@price.to_s)
  end
    
end
