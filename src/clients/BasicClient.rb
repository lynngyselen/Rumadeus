require 'Action'
require 'Util'
require 'Query'
require 'HLQuery'
require 'HLAction'

#puts Actions.new.query "3f4cdf33a688ae1e126e16e42e2a2f04"

#puts Query.new.listConnections "2012-01-31","BRU","CDG"

#puts Query.new.listDestinations "VIE"

#puts Query.new.listConnections "2012-01-31","TEG","AMS"

#puts Actions.new.query "e7f2a02364ff4bd7065fdde2306733ff"

#puts Query.new.listAirlines

#puts (HLQuery.new.multihop "2012-01-30", "AMS", "CDG", "VIE")

#puts (HLQuery.new.bestprice "2012-01-30","CDG", "VIE","E")

=begin
Query.new.combine do
  listConnections "2012-01-31","BRU","CDG"
  listDestinations "VIE"
  listConnections "2012-01-31","TEG","AMS"
  listAirlines
  listAirports
end
=end 

persons = []
persons << Person.new("FRUBY           RUBYRUB             ")
persons << Person.new("MLEROY          JENKINS             ")
persons << Person.new("FMARIE          CURRIE              ")

MultipleBookings.new.groupBooking(3, "2012-01-06", "SJT211", "E", persons) 
