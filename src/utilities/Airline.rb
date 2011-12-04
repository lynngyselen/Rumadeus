class Airline
  
  def initialize(input)
    input =~ /\w{3}/
    @code = Code.new($&)
    @name = $'
  end
  
  def to_s
    (@code.to_s) + " " + (@name.to_s)
  end
  
end
