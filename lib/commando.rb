require_relative 'commando/config'
require_relative 'commando/interpreter'
require_relative 'commando/io_handler'
require_relative 'commando/quit_exception'
require_relative 'commando/validation_error'
require_relative 'commando/version'

# Entry point for the Command Line Interface (CLI).
#
# Present the user with a text-based interface, where a prompt is printed,
# then commands are read from stardard in, then executed. This process is
# repeated indefinitely until the user give either the "quit" command, or
# presses <CMD>+D.
module Commando
  # Initialize and configure the global config object
  def self.configure(&block)
    yield config
  end

  def self.config
    @config ||= Config.new
  end

  # Begin the prompt, get input, process loop.
  def self.start(output: $stdout)
    output.puts config.greeting

    io = IOHandler.new(output: output)

    loop do
      begin
        if line = io.readline
          # When the user enters a non-empty string, pass the line to the
          # interpreter and handle the command.
          interpreter = Interpreter.new(input: line, output: output)
          interpreter.interpret
        end
      rescue ValidationError => error
        output.puts "Error: #{error}"
      rescue QuitException
        break
      end
    end
  end
end
