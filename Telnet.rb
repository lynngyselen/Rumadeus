require 'net/telnet'

class Telnet

def query(input)
  host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
  host.puts(input)
  result = []
  while line = host.gets
    result << line[0,line.length-1]
  end
  host.flush
  host.close
  
  return result
end

end