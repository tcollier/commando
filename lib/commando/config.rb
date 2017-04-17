require_relative 'action/help'
require_relative 'action/history'
require_relative 'action/quit'

module Commando
  ActionConfig = Struct.new(:action_class, :description)
  private_constant :ActionConfig

  # Manage the configuration for the actions available to the CLI
  class Config
    DEFAULT_PROMPT = 'commando> '
    DEFAULT_GREETING =
      'Welcome to the commando interface. Type "help" to list available commands'

    attr_accessor :history_file

    attr_writer :prompt, :greeting, :output

    def initialize
      @mapping = {}

      # Register the default actions
      register(
        'help',
        Commando::Action::Help.new(config: self),
        'Print this message'
      )
      register(
        'history',
        Commando::Action::History.new(config: self),
        'Print the history of commands'
      )
      register(
        'quit',
        Commando::Action::Quit.new,
        'Exit the program'
      )
    end

    def output
      @output || $stdout
    end

    def prompt
      @prompt || DEFAULT_PROMPT
    end

    def greeting
      @greeting || DEFAULT_GREETING
    end

    # Register a new command/action to be available to the CLI
    #
    # @param command [String] the string that a user will type to execute the
    #   action, e.g. "help" for the command the will print out help info.
    # @param action_class [Class] the class that will execute the logic for
    #   the given command.
    def register(command, action_class, description)
      mapping[command] = ActionConfig.new(action_class, description)
    end

    # @return [Array<String>] the list of all configured actions.
    def commands
      @mapping.keys
    end

    # @param command [String] the command to find an action class for.
    # @return [Class] the action class that is registered for the command,
    #   nil if none is registered.
    def lookup(command)
      mapping[command]&.action_class
    end

    # @return [Hash<String, String>] a map of commands to their descriptions
    def descriptions
      mapping.map.with_object({}) do |(command, action_config), hash|
        hash[command] = action_config.description
      end
    end

    private

    attr_reader :mapping
  end

  private_constant :Config
end
