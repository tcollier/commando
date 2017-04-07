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
      if history_file && File.exists?(history_file)
        File.readlines(history_file).each do |line|
          Readline::HISTORY.push(line.chomp)
        end
      end
    end

    def save_history(line)
      File.open(history_file, 'a') { |f| f.puts(line) } if history_file
    end

    def history_file
      Commando.config.history_file
    end
  end

  private_constant :IOHandler
end
