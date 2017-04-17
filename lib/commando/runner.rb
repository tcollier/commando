require_relative 'interpreter'
require_relative 'io_handler'
require_relative 'quit_exception'

module Commando
  class Runner
    def initialize(config:)
      @config = config
    end

    def start
      config.output.puts config.greeting

      io = IOHandler.new(config: config)
      interpreter = Interpreter.new(config: config)

      loop do
        begin
          if line = io.readline
            # When the user enters a non-empty string, pass the line to the
            # interpreter and handle the command.
            interpreter.interpret(line)
          end
        rescue ArgumentError => error
          config.output.puts "Error: #{error}"
        rescue QuitException
          break
        end
      end
    end

    private

    attr_reader :config
  end
end
