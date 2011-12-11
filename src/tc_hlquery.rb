require "test/unit"
require "date"
require "HLQuery.rb"

class HLQueryTest < Test::Unit::TestCase
  
  def setup
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

  end
  
  def test_withStops
    for i in 0..@ws_times-1 do      
      result = HLQuery.new.withStops(@ws_source[i],@ws_destination[i],@ws_hops[i])
      result.each do |res|
            for i in 0 .. (res.size-2)
            assert_equal(HLQuery.new.hasConnection(res[i],res[i+1]),true)
            end
       end
     end
  end

  def test_shortestTwo 
    shortest = HLQuery.new.shortestTwo(@s2_date,@s2_source,@s2_destination)
    test = []
    test |= Query.new.listConnections((Date.parse(@s2_date.year.to_s+"-"+@s2_date.month.to_s+"-"+@s2_date.day.to_s)).to_s,@s2_source,@s2_destination)
      test.each do |t|
        if (DateTime.parse(t.date.to_s+" "+t.deptime.to_s) > @s2_date)
          assert_equal(t.arrival >= shortest.arrival,true)
        end
      end
  end


  def test_shortestMultiple
    shortest = HLQuery.new.shortestMultiple(@sM_date,@sM_list)
    for i in 0 .. (@sM_list.size-2)
      assert_equal(shortest.connections[i], HLQuery.new.shortestTwo(@sM_date,@sM_list[i],@sM_list[i+1]))
    end
  end
      
  def test_shortestWithStops  
    shortest = HLQuery.new.shortestWithStops(@sW_date,@sW_source,@sW_destination,@sW_hops) 
    (HLQuery.new.withStops(@sW_source,@sW_destination,@sW_hops)).each do |p|
      assert_equal(shortest <= HLQuery.new.shortestMultiple(@sW_date,p),true)
    end
  end
end