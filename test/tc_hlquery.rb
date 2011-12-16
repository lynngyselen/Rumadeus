require "test/unit"
require "date"
require "HLQuery.rb"
require "utilities/Person.rb"

class HLQueryTest < Test::Unit::TestCase
  
  def setup
    @query = Query.new
    @hlquery = HLQuery.new
    @action = Action.new
    
    @klasse = "E"
    
    @ws_times = 2
    @ws_source = ["CDG","BRU"]
    @ws_destination = ["VIE","JFK"]
    @ws_hops = [3,3]
    
    @s2_date = DateTime.parse("25/01/2012 01:15") 
    @s2_source = "CDG"
    @s2_destination = "VIE"
    
    @sM_date = DateTime.parse("25/01/2012 01:15") 
    @sM_list = ["CDG","BRU","VIE"]
    
    @sW_date = DateTime.parse("31/01/2012-01:15") 
    @sW_source = "BRU"
    @sW_destination = "JFK"
    @sW_hops = 3
    
    @hm_person = Person.new("MRobin          Debruyne")
    @hm_source = "JFK"
    @hm_dest = "CDG"
    @hm_hops = 3
    
  #  @hops = @hlquery.shortestWithStops(@sW_date, @hm_source, @hm_dest, @hm_hops)
  #  @holds = @hlquery.holdMulti(@hops.connections, "E", @person)
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
    shortest = @hlquery.shortestTwo(@s2_date, @s2_source, @s2_destination,@klasse)
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
    shortest = @hlquery.shortestMultiple(@sM_date, @sM_list,@klasse)
    (0 .. (@sM_list.size - 2)).each do |i|
      assert_equal(shortest.connections[i],
        @hlquery.shortestTwo(@sM_date, @sM_list[i], @sM_list[i+1],@klasse))
    end
  end
 
  def test_shortestWithStops  
    shortest = @hlquery.shortestWithStops(@sW_date, @sW_source,
      @sW_destination, @sW_hops,@klasse) 
    (@hlquery.withStops(@sW_source, @sW_destination, @sW_hops)).each do |p|
      x =@hlquery.shortestMultiple(@sW_date, p,@klasse)
      if not x.nil?
        assert(shortest <= x)
      end
    end
  end

end
