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
    ((@status.to_s) + " " + (@date.to_s) + " " + (@time.to_s) + " " +
      (@duration.to_s) + " " + (@flightnr.to_s) + " " + (@klasse.to_s) + " " +
      (@person.to_s) + " " +(@price.to_s))
  end
  
end
