require_relative '../quit_exception'

module Commando
  module Action
    # Action to exit out of the CLI
    class Quit
      def perform(args:)
        raise QuitException
      end
    end
  end
end
