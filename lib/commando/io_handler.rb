require 'readline'

require_relative 'quit_exception'

module Commando
  # Handle the prompt/input for the command line interface
  class IOHandler
    def initialize(config:)
      @config = config

      configure_readline
      load_history
    end

    def readline
      line = Readline.readline(config.prompt, true)
      if line.nil?
        # When the user presses <CMD>+D, this comes through as nil. In that
        # case we want to exit
        config.output.puts
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

    attr_reader :config

    def configure_readline
      Readline.output = config.output
      Readline.completion_proc =
        proc { |s| config.commands.grep(/^#{Regexp.escape(s)}/) }
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
      config.history_file
    end
  end

  private_constant :IOHandler
end
