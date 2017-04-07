require_relative '../../../lib/commando/action/help'

module Commando
  RSpec.describe Action::Help do
    class TestAction1
      def self.description
        'Test action 1'
      end
    end

    class TestAction2
      def self.description
        'Test action 2'
      end
    end

    let(:output) { instance_double(IO) }

    describe '#perform' do
      before do
        Commando.configure do |config|
          config.register('testz', TestAction2, 'test action 1')
          config.register('testa', TestAction1, 'test action 2')
        end

        allow(output).to receive(:puts)
      end

      it 'puts an alphabetize list of commands to the output stream' do
        expect(output).to receive(:puts).with(/testa - test action 2/).ordered
        expect(output).to receive(:puts).with(/testz - test action 1/).ordered
        Action::Help.perform(args: [], output: output)
      end
    end
  end
end
