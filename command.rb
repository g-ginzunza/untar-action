class Command
  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ToGreet < Command
  def initialize(name)
    @name = name
  end

  def execute
    puts "Welcome, #{@name}!"
  end
end

class ComplexCommand < Command
  def initialize(receiver, a, b)
    @receiver = receiver
    @a = a
    @b = b
  end

  # Commands can delegate to any methods of a receiver.
  def execute
    print 'ComplexCommand: Complex stuff should be done by a receiver object'
    @receiver.cook_food(@a)
    @receiver.burn_the_kitchen(@b)
  end
end

# The Receiver classes contain some important business logic. They know how to
# perform all kinds of operations, associated with carrying out a request. In
# fact, any class may serve as a Receiver.
class Receiver
  # @param [String] a
  def cook_food(a)
    print "\nReceiver: Working on (#{a}.)"
  end

  # @param [String] b
  def burn_the_kitchen(b)
    print "\nReceiver: Destroying everything (#{b}.)"
  end
end

# The Invoker is associated with one or several commands. It sends a request to
# the command.
class Invoker
  # Initialize commands.

  # @param [Command] command
  def on_start=(command)
    @on_start = command
  end

  # @param [Command] command
  def on_finish=(command)
    @on_finish = command
  end

  # The Invoker does not depend on concrete command or receiver classes. The
  # Invoker passes a request to a receiver indirectly, by executing a command.
  def do_something_important
    puts 'Invoker: Does anybody want something done before I begin?'
    @on_start.execute if @on_start.is_a? Command

    puts 'Invoker: ...doing something really important...'

    puts 'Invoker: Does anybody want something done after I finish?'
    @on_finish.execute if @on_finish.is_a? Command
  end
end

# The client code can parameterize an invoker with any commands.
invoker = Invoker.new
invoker.on_start = ToGreet.new("Gustavo")
receiver = Receiver.new
invoker.on_finish = ComplexCommand.new(receiver, 'First order', '>:)')

invoker.do_something_important
