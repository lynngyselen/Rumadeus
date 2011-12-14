require "test/unit"
require "date"

require "HLQuery.rb"
require "Util"
require "utilities/Person.rb"

class Actionstest < Test::Unit::TestCase
  def setup
    @query = Query.new
    @hlquery = HLQuery.new
    @action = Actions.new

    @s1_status = "H"
    @s1_date = "2011-12-13" 
    @s1_flightnumber = "SJT211"
    @s1_klasse = "E"
    @s1_person = Person.new("FLYNN           GYSELEN             ")
    
    @s2_wrongcode = "2b37e87a1efe64ca6d891cee442e35fd"
    
    @s3_status = "B"
  end

  def test_hold_query_cancel
    h = @action.hold(@s1_date, @s1_flightnumber, @s1_klasse, 
      @s1_person.gender, @s1_person.firstname, @s1_person.surname)[0]
    q = (@action.query h.code)[0]
    assert_equal(@s1_status , q.status)
    assert_equal(@s1_flightnumber, q.flightcode)
    assert_equal(@s1_person, q.person)
    @action.cancel h.code
  end
  
  def test_hold_cancel
    h = @action.hold(@s1_date, @s1_flightnumber, @s1_klasse, 
      @s1_person.gender, @s1_person.firstname, @s1_person.surname)[0]
    @action.cancel h.code
    assert_raise(Util::ReservationError) {
      @action.cancel h.code
    }
  end
  
  def test_wrong_query
    assert_raise(Util::ReservationError){
      @action.query @s2_wrongcode
    }
  end
  
  def test_book
    h = @action.hold(@s1_date, @s1_flightnumber, @s1_klasse, 
      @s1_person.gender, @s1_person.firstname, @s1_person.surname)[0]
    b = (@action.book h.code)[0]
    q = (@action.query h.code)[0]
    assert_equal(@s3_status , q.status)
    assert_equal(@s1_flightnumber, b.flightcode)
    assert_raise(Util::ReservationError) {
      @action.book h.code
    }
    @action.cancel h.code
  end
end