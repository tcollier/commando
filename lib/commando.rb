require_relative 'commando/config'
require_relative 'commando/runner'

# Entry point for the Command Line Interface (CLI).
#
# Present the user with a text-based interface, where a prompt is printed,
# then commands are read from stardard in, then executed. This process is
# repeated indefinitely until the user give either the "quit" command, or
# presses <CMD>+D.
module Commando
  # Begin the prompt, get input, process loop.
  def self.start(&block)
    config = Config.new
    yield config if block_given?
    Runner.new(config: config).start
  end
end
