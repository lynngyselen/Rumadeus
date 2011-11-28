require ’net/telnet’
host = Net::Telnet.new(’Host’ => ’localhost’, ’Port’ => 12111)
host.puts("A")
while line = host.gets
puts line
end
host.flush
host.close
