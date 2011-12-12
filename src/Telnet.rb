require 'net/telnet'

class Telnet

  # Newer Ruby does not have a gets method in Telnet anymore, use cmd instead.
  def query input
    host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
    
    result = if host.respond_to? :cmd then
        newQuery(input, host)
      else
        oldQuery(input, host)
      end
        
    if not result.empty? and (result.at 0).start_with? "ERR"
      raise Util::ServerError.new (result.at 0)
    end
    
    # Return an empty array instead of nil when the query has no results.
    result || []
  end
  
  # With command, the reply consists of a single multi-line string.
  # We convert this to an array of lines.
  def newQuery(input, host)
    output = host.cmd input
    close host
    output.nil? ? [] : output.split("\n")
  end
  
  def oldQuery(input, host)
    results = []
    host.puts input
    while line = host.gets
      results << line[0, line.length - 1]
    end
    host.flush
    host.close
    results
  end
  
  def close host
    if host.respond_to? "close"
      host.close
    end
  end
  
end
