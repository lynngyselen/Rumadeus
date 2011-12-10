require 'Util'

class Code
  
  attr_reader :code

  def initialize code
    @code = Util::lengthCheck(code, 3)
  end	

  def to_s
    @code
  end
  
  def == other
    self.code == other.code
  end

end
