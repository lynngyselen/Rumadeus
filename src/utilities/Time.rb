module TimeM
  
  class InternalTime
    attr_reader :hours, :minutes
    
    def initialize input
      if not (input =~ regex).nil?
        @hours = $1.to_i
        @minutes = $2.to_i
      else
        raise Util::InvalidInputException
      end
    end
    
    def regex
      %r{(\d{2}):(\d{2})}
    end
    
    def to_s
      (padWithZeroes @hours) + ":" + (padWithZeroes @minutes)
    end
    
    def padWithZeroes int
      (int < 10 ? "0" : "") + int.to_s
    end
  end
  
  def TimeM::parseTime input
    TimeM::Time.new input
  end
  
  def TimeM::parseDuration input
    TimeM::Duration.new input
  end

  class Time < InternalTime
    def regex
      %r{([0-2][0-9]):([0-5][0-9])} 
    end
  end
  
  class Duration < InternalTime; end
end
