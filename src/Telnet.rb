require 'net/telnet'

class Telnet

  # Newer Ruby does not have a gets method in Telnet anymore, use cmd instead.
  def query(input)
    host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
    
    return host.respond_to?("cmd") ?
        newQuery(input, host) :
        oldQuery(input, host)
  end
  
  def newQuery(input, host)
    results = []
    host.cmd input do |result|
      results << result
    end
    return results
  end
  
  def oldQuery(input, host)
    results = []
    host.puts input
    while line = host.gets
      results << line[0, line.length - 1]
    end
    host.flush
    host.close
    return results
  end
  
end
