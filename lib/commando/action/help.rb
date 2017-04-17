require_relative '../../commando'

module Commando
  module Action
    # Action that prints out all available commands
    class Help
      def initialize(config:)
        @config = config
      end

      def perform(args:)
        config.output.puts "Valid commands are"
        descriptions = config.descriptions
        descriptions.sort_by { |cmd, _| cmd }.each do |command, description|
          config.output.puts "  * #{command} - #{description}"
        end
      end

      private

      attr_reader :config
    end
  end
end
