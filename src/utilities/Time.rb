class Time
  def initialize(input)
    input =~ /(\d{2})(:)(\d{2})/
    @hour = $1
    @minute = $3
  end
  
  def to_s
    (@hour.to_s) + ":" + (@minute.to_s)
  end
  
end
