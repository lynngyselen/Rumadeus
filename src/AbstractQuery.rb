require 'Telnet'

class AbstractQuery
  
  def initialize
    @telnet = Telnet.new
  end
  
  def method_missing *args
    delegate.public_send *args
  end
  
  def help
    (Util::method_parameters self).concat delegate.help
  end
  
  alias :h :help
  
end
