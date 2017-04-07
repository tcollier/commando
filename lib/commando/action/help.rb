require_relative '../../commando'

module Commando
  module Action
    # Action that prints out all available commands
    module Help
      def self.perform(args:, output: $stdout)
        output.puts "Valid commands are"
        descriptions = Commando.config.descriptions
        descriptions.sort_by { |cmd, _| cmd }.each do |command, description|
          output.puts "  * #{command} - #{description}"
        end
      end
    end
  end
end
