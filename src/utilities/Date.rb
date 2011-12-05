class Date
  
  def initialize(input)
    input =~ /(\d+)(-)(\d+)(-)(\d+)/
    @year = $1
    @month = $3
    @day = $5
  end
  
  def to_s
    (@year.to_s) + "-" + (@month.to_s) + "-" + (@day.to_s)
  end
  
end
