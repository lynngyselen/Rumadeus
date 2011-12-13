require 'Telnet'
require 'Util'

class AbstractQuery
  
  def initialize
    @telnet = Telnet.new
  end
  
  # Subclasses should make sure to implement the delegate method,
  # otherwise we will probably get an infinite loop here
  def method_missing(name_sym, *args)
    # puts "Method missing: (#{self}) delegating call #{args.join " "}"
    if name_sym.to_s.start_with? Util::QUERY_ID
      delegate.public_send(name_sym, *args)
    else
      super
    end
  end
  
  def help
    ((Util::method_parameters self).concat delegate.help).uniq.sort
  end
  
  alias :query_help :help
  alias :query_h :help
  
end
