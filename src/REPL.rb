require 'Query'

query = Query.new

begin
  input = gets.delete("\n\"").split(%r{[/[[:blank:]]/,]+})
  
  if not input.at(0).nil?
    if input.length > 0
      if query.respond_to? input.at(0)
        begin
          puts query.send(*input)
        rescue ArgumentError
          puts "You did not supply the correct amount of arguments."
        end
      else
        puts "This command does not exist."
      end
    end
  end
  puts "\n"
end while true
