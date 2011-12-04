class Airport
    
  def initialize(input)
    input =~ /(\w{3})([A-Za-z ]{20})([A-Za-z ]{20})/
    @code = Code.new($1)
    @city = $2
    @country = $3
  end
  
  def to_s
    (@code.to_s) + " " + (@city.to_s) + " " + (@country.to_s)
  end
  
end
