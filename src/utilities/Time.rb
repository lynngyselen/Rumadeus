module TimeM
  
  # The preferred way of obtaining a Time or Duration object is to use one of
  # the following two factory methods.
  
  def TimeM::parseTime input
    Time.new input
  end
  
  def TimeM::parseDuration input
    Duration.new input
  end
  
  
  module Internal
    class InternalTime
      include Comparable
    
      attr_reader :hours, :minutes
    
      def initialize input
        if not (input =~ regex).nil?
          @hours = input[0..1].to_i
          @minutes = input[3..4].to_i
        else
          raise Util::InvalidInputException
        end
      end
    
      def regex
        /(\d{2}):(\d{2})/
      end
    
      def to_s
        "#{padWithZeroes @hours}:#{padWithZeroes @minutes}"
      end
    
      def padWithZeroes int
        (int < 10 ? "0" : "") + int.to_s
      end
    
      def <=> other
        if self.hours == other.hours
          self.minutes <=> other.minutes
        else
          self.hours <=> other.hours
        end
      end
    
    end
  end

  class Time < Internal::InternalTime
    def regex
      /([0-1]\d|2[0-3]):([0-5]\d)/
    end
  end
  
  class Duration < Internal::InternalTime; end
end
