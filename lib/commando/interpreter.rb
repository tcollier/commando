module Commando
  # Interpret a single command from the user.
  class Interpreter
    # @param config [Config] the application configuration
    def initialize(config:)
      @config = config
    end

    # Performs the action (if valid) for the given input command line
    #
    # @param line [String] the entire command line string.
    def interpret(line)
      args = line.split(' ')
      command = args.shift
      action = config.lookup(command)

      if action.nil?
        config.output.puts %Q(Unrecognized command: #{command}. Type "help" for a list of valid commands)
      else
        action.perform(args: args)
      end
    end

    private

    attr_reader :config
  end

  private_constant :Interpreter
end
