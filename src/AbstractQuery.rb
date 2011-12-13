require 'Telnet'

class AbstractQuery
  
  def initialize
    @telnet = Telnet.new
  end
  
  # Subclasses should make sure to implement the delegate method,
  # otherwise we will probably get an infinite loop here
  def method_missing *args
    # puts "Method missing: (#{self}) delegating call #{args.join " "}"
    delegate.public_send *args
  end
  
  def help
    ((Util::method_parameters self).concat delegate.help).uniq.sort
  end
  
  alias :query_help :help
  alias :query_h :help
  
end
