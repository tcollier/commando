require_relative '../../lib/commando/interpreter'

module Commando
  RSpec.describe Interpreter do
    subject { Interpreter.new(input: 'foo bar baz', output: output) }

    let(:output) { instance_double(IO) }

    before do
      allow(Commando.config).to receive(:lookup).with('foo').and_return(action)
    end

    describe '#interpret' do
      describe 'when no action is configured for the command' do
        let(:action) { nil }

        it 'prints a useful message' do
          message =
            'Unrecognized command: foo. Type "help" for a list of valid commands'
          expect(output).to receive(:puts).with(message)
          subject.interpret
        end
      end

      describe 'when an action is configured for the command' do
        let(:action) { double(:action) }

        it 'prints a useful message' do
          expect(action).to receive(:perform)
            .with(args: %w[bar baz], output: output)
          subject.interpret
        end
      end
    end
  end
end
