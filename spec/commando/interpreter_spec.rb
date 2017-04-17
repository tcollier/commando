require_relative '../../lib/commando/interpreter'

module Commando
  RSpec.describe Interpreter do
    describe '#interpret' do
      subject { Interpreter.new(config: config) }

      let(:config) { Config.new }
      let(:output) { instance_double(IO) }

      before do
        config.output = output
        allow(config).to receive(:lookup).with('foo').and_return(action)
      end

      describe 'when no action is configured for the command' do
        let(:action) { nil }

        it 'prints a useful message' do
          message =
            'Unrecognized command: foo. Type "help" for a list of valid commands'
          expect(output).to receive(:puts).with(message)
          subject.interpret('foo bar baz')
        end
      end

      describe 'when an action is configured for the command' do
        let(:action) { double(:action) }

        it 'prints a useful message' do
          expect(action).to receive(:perform).with(args: %w[bar baz])
            subject.interpret('foo bar baz')
        end
      end
    end
  end
end
