require 'Query'

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
  
  def input
    (gets.delete "\n\"").split %r{[/[[:blank:]]/,]+}
  end
  
  def parseInput input
    if not_empty? input
      if @query.respond_to? input.at 0
        begin
          query input
        rescue ArgumentError
          "You did not supply the correct amount of arguments."
        end
      else
        "This command does not exist."
      end
    end
  end
  
  def query input
    out = @query.send *input
    if out.empty?
      "(Empty result.)"
    else
      out
    end
  end
  
  def not_empty? input
    input.length > 0 and not (input.at 0).nil?
  end
  
end

if __FILE__ == $0
  REPL.new.run
end
