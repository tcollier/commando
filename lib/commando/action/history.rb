require 'readline'

module Commando
  module Action
    # Action that prints out command history
    class History
      def initialize(config:)
        @config = config
      end

      def perform(args:)
        max_digits = Math.log(Readline::HISTORY.size, 10).ceil
        Readline::HISTORY.each.with_index do |history, index|
          line_no = (index + 1).to_s.rjust(max_digits, ' ')
          config.output.puts " #{line_no}\t#{history}"
        end
      end

      private

      attr_reader :config
    end
  end
end
