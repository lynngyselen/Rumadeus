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
      @sW_destination, @sW_hops,@klasse) 
    @person1 = Person.new("MRobin          Debruyne")
    @person2 = Person.new("MMathias        Spiessens")
    @persons = [@person1,@person2]

  end

  def test_all
    @holds = @hlaction.hold_multi(2,2,@klasse,"M","Mathias","Spiessens","M","Robin","Debruyne",@path.connections[0].date.to_s,@path.connections[0].flightcode,@path.connections[1].date.to_s,@path.connections[1].flightcode)
    @books = @hlaction.books(@holds)
    @queri = @hlaction.queries(@holds)
    
    assert_equal(@queri.size,4)
    
    @hlaction.cancelall(@holds)
    @queri = @hlaction.queries(@holds)
    assert_equal(0,@queri.size)
    
  end


  def test_multi
    
  end

=begin
  def test_holdmulti
      @holds.each do |h|
        b = @action.book h
        q = @action.query b
        assert_equal(b.flightcode, q.flightcode)
        assert_equal(b.person, q.person)
      end
      if @holds.size > 0
        assert_equal(@holds.size, @hops.connections.size)
      end
      @hlquery.cancelMulti @holds
  end
  
  def test_cancelmulti
    @hlquery.cancelMulti @holds
    @holds.each do |h|
      b = @action.query h
      assert_equal(false,true)
    end
  end
  
  def test_bookmulti
    @holds = @hlquery.holdMulti(@hops.connections, "E", @person)
    bookings = @hlquery.bookMulti @holds
    bookings.each do |b|
      q = @action.query b
      assert_equal("E", q.class)
      assert_equal(@person, q.person)
    end
    @hlquery.cancelMulti @holds
  end
=end
end