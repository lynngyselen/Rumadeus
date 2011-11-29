require 'net/telnet'

class Telnet

def query(input)
  host = Net::Telnet.new('Host' => 'localhost', 'Port' => 12111)
  host.puts(input)
  while line = host.gets
    puts line
  end
  host.flush
  host.close
end

end