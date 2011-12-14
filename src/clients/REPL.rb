require 'date'

require 'Query'
require 'Util'

class REPL
  
  def initialize
    @query = Query.new
  end
  
  def run
    while true
      puts parseInput input
      puts "\n"
    end
  end
  
  # Remove newline and quote characters and split on any combination of
  # whitespace and commas. 
  def input
    (gets.delete "\n\"").split /[[[:blank:]],]+/
  end
  
  def parseInput input
    if not empty? input
      begin
        query input
      rescue ArgumentError
        "You did not supply the correct amount of arguments."
      rescue Util::InvalidInputException
        "Your arguments are invalid..."
      rescue Util::ReservationError => e
        "Error: #{e.message}"
      rescue Util::ServerError => error
        handle_server_error error
      rescue Util::ReservationError => error
        error.inspect
      end
    end
  end
  
  def handle_server_error error
    case error.cause
      when Util::ServerError::ERRNR
        empty_result
      else
        error.cause
    end
  end
  
  def empty_result
    "(Empty result.)"
  end
  
  def query input
    out = @query.public_send *(input.each_with_index.map do |x, i|
      if i == 0 then Util::add_query x else x end
    end)
    if nil? out
      empty_result
    else
      out
    end
  end
  
  def empty? input
    input.nil? or input.empty? or input[0].nil?
  end
  
end

if __FILE__ == $0
  REPL.new.run
end
