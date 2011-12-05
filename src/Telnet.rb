require 'net/telnet'

class Telnet

  # Newer Ruby does not have a gets method in Telnet anymore, use cmd instead.
  def query input
    host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
    
    result = host.respond_to?("cmd") ?
        newQuery(input, host) :
        oldQuery(input, host)
        
    if (result.at 0).start_with? "ERR"
      raise Util::InvalidInputException, "Server gave error #{result}"
    end
  end
  
  # With command, the reply consists of a single multi-line string.
  # We convert this to an array of lines.
  def newQuery(input, host)
    result = stringToArray(host.cmd input)
    host.close
    result
  end
  
  def stringToArray string
    results = []
    if not string.nil?
      (string.split "\n").each do |result|
        results << result
      end
    end
    results
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
  
end
