class Path
  include Comparable
  
  attr_reader :date, :connections, :duration
  
  def initialize(date, connections)
    @date = DateTime.parse date.to_s
    @connections = connections
    @duration = connections[connections.size - 1].arrival_time.to_time - date.to_time
  end
  
  def <=> other
    self.duration <=> other.duration
  end
   
  def to_s
    "#{@connections.to_s} #{@duration.to_s}"
  end
end
