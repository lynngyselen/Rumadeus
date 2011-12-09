class SeatPrice
  include Comparable
  
  attr_reader :price
  
  def initialize input
    @seats = input[0, 3].to_i
    @price = input[3, 8].to_i
  end
  
  def <=> other
    self.price <=> other.price
  end
  
  def to_s
    (@seats.to_s) + " " + (@price.to_s)
  end
    
end
