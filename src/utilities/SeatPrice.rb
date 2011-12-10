class SeatPrice
  include Comparable
  
  attr_reader :seats, :price
  
  def initialize input
    @seats = input[0..2].to_i
    @price = input[3..7].to_i
  end
  
  def <=> other
    self.price <=> other.price
  end
  
  def to_s
    "#{@seats.to_s} #{@price.to_s}"
  end
    
end
