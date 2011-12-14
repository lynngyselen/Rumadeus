require "test/unit"
require "date"
require "HLQuery.rb"
require "utilities/Person.rb"

class HLQueryTest < Test::Unit::TestCase
  
  def setup
    @query = Query.new
    @hlquery = HLQuery.new
    @action = Actions.new
    
    @ws_times = 2
    @ws_source = ["CDG","BRU"]
    @ws_destination = ["VIE","JFK"]
    @ws_hops = [3,3]
    
    @s2_date = DateTime.parse("25/01/2012 01:15") 
    @s2_source = "CDG"
    @s2_destination = "VIE"
    
    @sM_date = DateTime.parse("25/01/2012 01:15") 
    @sM_list = ["CDG","BRU","VIE"]
    
    @sW_date = DateTime.parse("25/01/2012 01:15") 
    @sW_source = "CDG"
    @sW_destination = "VIE"
    @sW_hops = 2
    
    @hm_person = Person.new("MRobin          Debruyne")
    @hm_source = "JFK"
    @hm_dest = "CDG"
    @hm_hops = 3
    
    @hops = @hlquery.shortestWithStops(@sW_date, @hm_source, @hm_dest, @hm_hops)
    @holds = @hlquery.holdMulti(@hops.connections, "E", @person)
  end

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
  
  def test_withStops
    for i in 0 .. @ws_times - 1 do
      result = @hlquery.withStops(@ws_source[i], @ws_destination[i], @ws_hops[i])
      result.each do |res|
        for i in 0 .. (res.size - 2)
          assert @hlquery.hasConnection(res[i], res[i+1])
        end
      end
    end
  end

  def test_shortestTwo 
    shortest = @hlquery.shortestTwo(@s2_date, @s2_source, @s2_destination)
    test = []
    date = Date.parse "#{@s2_date.year.to_s}-#{@s2_date.month.to_s}-" +
      "#{@s2_date.day.to_s}"
    test |= @query.listConnections(date.to_s, @s2_source, @s2_destination)
    test.each do |t|
      if (DateTime.parse("#{t.date.to_s} #{t.deptime.to_s}") > @s2_date)
        assert(t.arrival_time >= shortest.arrival_time)
      end
    end
  end

  def test_shortestMultiple
    shortest = @hlquery.shortestMultiple(@sM_date, @sM_list)
    (0 .. (@sM_list.size - 2)).each do |i|
      assert_equal(shortest.connections[i],
        @hlquery.shortestTwo(@sM_date, @sM_list[i], @sM_list[i+1]))
    end
  end
  
  def test_shortestWithStops  
    shortest = @hlquery.shortestWithStops(@sW_date, @sW_source,
      @sW_destination, @sW_hops) 
    (@hlquery.withStops(@sW_source, @sW_destination, @sW_hops)).each do |p|
      assert(shortest <= @hlquery.shortestMultiple(@sW_date, p))
    end
  end

end
