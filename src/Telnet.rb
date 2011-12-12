require 'net/telnet'

class Telnet

  def query input
    host = init_connection
    
    handle_result host.respond_to?(:cmd) ?
        newQuery(input, host) :
        oldQuery(input, host)
  end
  
  def init_connection
    Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
  end
  
  def handle_result result
    if error? result
      raise Util::ServerError.new (result.at 0)
    else
      result | [] # Return an empty array instead of nil
    end
  end
  
  def error? input
    not input.empty? and (input.at 0).start_with? "ERR"
  end
  
  # Newer Ruby does not have a gets method in Telnet anymore, use cmd instead.
  def newQuery(input, host)
    output = host.cmd input
    close host
    if output.nil? then [] else output.split("\n") end
  end
  
  # For older Ruby versions
  def oldQuery(input, host)
    results = []
    host.puts input
    while line = host.gets
      results << line[0, line.length - 1]
    end
    close host
    results
  end
  
  # Find out at runtime which cleanup procedures the host is familiar with,
  # this has changed even between different 1.9.x versions, it seems
  def close host
    [:flush, :close].each do |op|
      if host.respond_to? op
        host.send op
      end
    end
  end
  
end
