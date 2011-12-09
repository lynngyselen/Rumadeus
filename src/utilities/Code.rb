require 'Util'

class Code

  def initialize(code)
    @code = Util.lengthCheck(code, 3)
  end	

  def to_s
    @code
  end
  
  def == other
    (self.to_s == other.to_s)
  end

end
