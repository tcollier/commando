require 'readline'

require_relative 'quit_exception'

module Commando
  # Handle the prompt/input for the command line interface
  class IOHandler
    def initialize(output:)
      @output = output

      configure_readline
      load_history
    end

    def readline
      line = Readline.readline(Commando.config.prompt, true)
      if line.nil?
        # When the user presses <CMD>+D, this comes through as nil. In that
        # case we want to exit
        output.puts
        raise QuitException
      elsif line.strip == ''
        # If the user just hit enter without typing a command, remove that line
        # from history.
        Readline::HISTORY.pop
        nil
      else
        save_history(line)
        line
      end
    end

    private

    attr_reader :output

    def configure_readline
      Readline.output = output
      Readline.completion_proc =
        proc { |s| Commando.config.commands.grep(/^#{Regexp.escape(s)}/) }
    end

    def load_history
      if Commando.config.history_file
        File.readlines(Commando.config.history_file).each do |line|
          Readline::HISTORY.push(line.chomp)
        end
      end
    end

    def save_history(line)
      if Commando.config.history_file
        File.open(Commando.config.history_file, 'a') do |f|
          f.puts line
        end
      end
    end
  end

  private_constant :IOHandler
end
