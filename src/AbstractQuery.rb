require 'Telnet'

class AbstractQuery
  
  def initialize
    @telnet = Telnet.new
  end
  
  # Subclasses should make sure to implement the delegate method,
  # otherwise we will probably get an infinite loop here
  def method_missing *args
    delegate.public_send *args
  end
  
  def help
    (Util::method_parameters self).concat delegate.help
  end
  
  alias :h :help
  
end
