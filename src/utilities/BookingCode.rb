class BookingCode
  def initialize(input)
    @code = Util.lengthCheck(input,32)
  end
end
