require 'readline'

module Commando
  module Action
    # Action that prints out command history
    module History
      def self.perform(args:, output: $stdout)
        max_digits = Math.log(Readline::HISTORY.size, 10).ceil
        Readline::HISTORY.each.with_index do |history, index|
          line_no = (index + 1).to_s.rjust(max_digits, ' ')
          output.puts " #{line_no}\t#{history}"
        end
      end
    end
  end
end
