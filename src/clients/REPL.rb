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
      rescue Util::ServerError => e
        e.cause
      end
    end
  end
  
  def query input
    out = @query.send *input
    if empty? out
      "(Empty result.)"
    else
      out
    end
  end
  
  def empty? input
    input.empty? or (input.at 0).nil?
  end
  
end

if __FILE__ == $0
  REPL.new.run
end
