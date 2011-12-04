class Connection
  
  def initialize(input)
    input =~ /(\w{3}\d{3})([0-9:]{5})([0-9:]{5})/ 
    @flightnr = $1
    @deptime = Time.new($2)
    @duration = Time.new($3)   
  end
  
  attr_accessor :date, :departure, :arrival
  attr_reader :flightnr 
  
  def to_s
    (@date.to_s) + " " + (@departure.to_s) + " " + (@arrival.to_s) + " " + 
      (@flightnr.to_s) + " " + (@deptime.to_s) + " " + (@duration.to_s)
  end
  
end
