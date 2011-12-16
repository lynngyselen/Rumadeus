require "test/unit"
require "date"

require "HLQuery.rb"
require "HLAction.rb"
require "Util"
require "utilities/Person.rb"

class HLActionstest < Test::Unit::TestCase
  def setup
    @query = Query.new
    @hlquery = HLQuery.new
    @hlaction = HLAction.new
    @action = Action.new
    
    @sW_date = DateTime.parse("31/01/2012-01:15") 
    @sW_source = "BRU"
    @sW_destination = "JFK"
    @sW_hops = 3
    @klasse = "E"
    @path = @hlquery.shortestWithStops(@sW_date, @sW_source,
      @sW_destination, @sW_hops,@klasse).first 
    @person1 = Person.new("MRobin          Debruyne")
    @person2 = Person.new("MMathias        Spiessens")
    @persons = [@person1,@person2]
  end

  def test_all
    @holds = @hlaction.hold_multi(2,2,@klasse,"M","Mathias","Spiessens","M","Robin","Debruyne",@path.connections[0].date.to_s,@path.connections[0].flightcode,@path.connections[1].date.to_s,@path.connections[1].flightcode)
    @hcs = []
    @holds.each do |h|
      @hcs << h.code
    end
    @books = @hlaction.books(@hcs)
    @queri = @hlaction.queries(@hcs)
    
    assert_equal(@queri.size,4)
    
    @hlaction.cancelall(@hcs)
    @queri = @hlaction.queries(@hcs)
    assert_equal(0,@queri.size)
    
  end
end