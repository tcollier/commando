require_relative 'commando/config'
require_relative 'commando/interpreter'
require_relative 'commando/quit_exception'
require_relative 'commando/validation_error'
require_relative 'commando/version'

require 'readline'
# Configure readline
comp = proc { |s| Commando.config.commands.grep(/^#{Regexp.escape(s)}/) }

Readline.completion_append_character = " "
Readline.completion_proc = comp

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
    Readline.output = output
    output.puts config.greeting
    quit = false

    loop do
      line = Readline.readline(config.prompt, true)

      if line.nil?
        # When the user presses <CMD>+D, this comes through as nil. In that
        # case we want to exit
        output.puts
        break
      elsif line.strip != ''
        # When the user enters a non-empty string, pass the line to the
        # interpreter and handle the command.
        #
        # If the user enters an empty string (e.g. "" or "   "), we simply
        # go back to the top of the loop to print out the prompt and wait
        # for the next command.
        interpreter = Interpreter.new(input: line, output: output)

        begin
          interpreter.interpret
        rescue ValidationError => error
          output.puts "Error: #{error}"
        rescue QuitException
          break
        end
      end
    end
  end
end
