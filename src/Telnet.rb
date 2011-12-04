require 'net/telnet'

class Telnet

  # Newer Ruby does not have a gets method in Telnet anymore, use cmd instead.
  def query(input)
    host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
    
    host.respond_to?("cmd") ?
        newQuery(input, host) :
        oldQuery(input, host)
  end
  
  def newQuery(input, host)
    stringToArray(host.cmd input)
  end
  
  def stringToArray(string)
    results = []
    if not string.nil?
      string.split("\n").each do |result|
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
