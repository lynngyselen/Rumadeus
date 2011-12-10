require "test/unit"

require "utilities/Person"

class PersonTest < Test::Unit::TestCase
 
  def setup
    @gender = "M"
    @firstname = "Ramses         "
    @surname = "De Norre            "
    
    @person = Person.new("#{@gender}#{@firstname}#{@surname}")
  end
 
  def test_initialize
    assert_equal(@gender, @person.gender)
    assert_equal(@firstname, @person.firstname)
    assert_equal(@surname, @person.surname)
  end
  
  def test_to_s
    str = "#{@gender} #{@firstname} #{@surname}"
    assert_equal(str, @person.to_s)
  end
  
  def test_equals
    personEq = Person.new("#{@gender}#{@firstname}#{@surname}")
    personsNE = [Person.new("F#{@firstname}#{@surname}"),
                 Person.new("#{@gender}John           #{@surname}"),
                 Person.new("#{@gender}#{@firstname}Doe                 ")]
    assert_equal(@person, personEq)
    personsNE.each do |person|
      assert_not_equal(@person, person)
    end
  end
 
end
