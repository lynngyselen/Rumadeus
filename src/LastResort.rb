# The entry point of our chain of command, responsible for politely informing
# the user that he executed a non-existing command. 
class LastResort
  
  def method_missing *args
    ["No such command..."]
  end
  
end
