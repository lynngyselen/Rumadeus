require 'Util'

class Code

  def initialize(code)
    @code = Util.lengthCheck(code, 3)
  end	

  def to_s
    @code
  end

end
