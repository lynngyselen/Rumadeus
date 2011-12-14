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
    ((method_parameters self).concat delegate.help).uniq.sort
  end
  
  def method_parameters object
    result = []
    object.methods.each do |method|
      if method_start_with_query?(method, object)
        result << format_method(method, object)
      end
    end
    result
  end
  
  def format_method (method, object)
    str = Util::remove_query method.to_s.rstrip
    params = parameters(object, method).rstrip
    if not params.empty?
      str += " : #{params}"
    end
    str.rstrip
  end
  
  def method_start_with_query? (method, object)
    (object.class.instance_method method).name.to_s.start_with? Util::QUERY_ID
  end
  
  def parameters(object, method)
    object.class.instance_method(method).parameters.map { |param|
      transform_parameter param
    }.join(" ")
  end
  
  def transform_parameter param
    if param[0] == :req
      param[1].to_s
    elsif param[0] == :opt
      "(#{param[1].to_s})"
    elsif param[0] == :rest
      "*#{param[1].to_s}"
    end
  end
  
  alias :query_help :help
  alias :query_h :help
  
end
