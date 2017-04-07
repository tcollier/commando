module Commando
  # Interpret a single command from the user.
  class Interpreter
    # @param output [IO] the stream any actions should write messages to.
    def initialize(output: $stdout)
      @output = output
    end

    # Performs the action (if valid) for the given input command line
    #
    # @param line [String] the entire command line string.
    def interpret(line)
      args = line.split(' ')
      command = args.shift
      action = Commando.config.lookup(command)

      if action.nil?
        output.puts %Q(Unrecognized command: #{command}. Type "help" for a list of valid commands)
      else
        action.perform(args: args, output: output)
      end
    end

    private

    attr_reader :output
  end

  private_constant :Interpreter
end
