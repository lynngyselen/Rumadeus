require 'date'

require 'Query'
require 'Util'

class REPL
  
  def initialize
    @query = Query.new
  end
  
  def welcome
    puts "Welcome to Rumadeus!\ntype help for a list of commands.\n\n"
  end
  
  def run
    welcome
    while true
      puts parseInput input
      puts "\n"
    end
  end
  
  # Remove newline and quote characters and split on any combination of
  # whitespace and commas. 
  def input
    print "Rumadeus > "
    (gets.delete "\n\"").split /[[[:blank:]],]+/
  end
  
  def parseInput input
    if not empty? input
      begin
        query input
      rescue ArgumentError => error
        "You did not supply the correct amount of arguments." + 
        "\n#{error.message.capitalize}."
      rescue Util::InvalidInputException
        "Your arguments are invalid..."
      rescue Util::ReservationError => error
        "Error: #{error.message}"
      rescue Util::ServerError => error
        handle_server_error error
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
    out = @query.public_send *(format input)
    if empty? out
      empty_result
    else
      out
    end
  end
  
  # Prepend Util::QUERY_ID to the first element of input
  def format input
    [(Util::add_query input[0]), *(input.drop 1)]
  end
  
  def empty? input
    input.nil? or input.empty? or input[0].nil?
  end
  
end

if __FILE__ == $0
  REPL.new.run
end
