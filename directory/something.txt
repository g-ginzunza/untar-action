class Database
  def to_date
    'Target: The default database\'s behavior.'
  end
end

class Postgres
  def to_date
    "SELECT TO_DATE ('20180314121212','yyyymmddhh24miss') FROM dual"
  end
end

class Oracle
  def to_date
    "SELECT TO_TIMESTAMP ('20180314121212','yyyymmddhh24miss')::TIMESTAMP(0)"
  end
end

class Adapter < Database
  def initialize(adaptee)
    @adaptee = adaptee
  end

  def to_date
    adaptee.to_date
  end
end

# The client code supports all classes that follow the Target interface.
def client_code(target)
  print target.to_date
end

puts 'Client: I can work just fine with the Target objects:'
target = Database.new
client_code(target)
puts "\n\n"

adaptee = Postgres.new
adapter = Adapter.new(adaptee)
client_code(adapter)
