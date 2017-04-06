module Commando
  # Interpret a single command from the user.
  class Interpreter
    # @param input [String] the entire command line string.
    # @param output [IO] the stream any actions should write messages to.
    def initialize(input:, output: $stdout)
      @args = input.split(' ')
      @command = @args.shift
      @output = output
    end

    # Performs the action (if valid) for the given input command line
    def interpret
      action = Commando.config.lookup(command)

      if action.nil?
        output.puts %Q(Unrecognized command: #{command}. Type "help" for a list of valid commands)
      else
        action.perform(args: args, output: output)
      end
    end

    private

    attr_reader :command, :args, :output
  end

  private_constant :Interpreter
end
