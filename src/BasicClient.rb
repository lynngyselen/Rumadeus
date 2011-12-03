require 'Actions'
require 'Util'
require 'Queries'

#Actions.new.holding "2011-11-05","AFR001","B","M","Dave","Clarke"

#puts Actions.new.query "3f4cdf33a688ae1e126e16e42e2a2f04"

#puts Query.new.listConnections "2012-01-31","BRU","CDG"

#puts Query.new.listDestinations "AMS"

puts Query.new.listConnections "2012-01-31","TEG","AMS"

puts Actions.new.query "e7f2a02364ff4bd7065fdde2306733ff"
