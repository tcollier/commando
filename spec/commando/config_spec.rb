require_relative '../../lib/commando/config'

module Commando
  RSpec.describe Config do
    describe 'default actions' do
      it 'configured "help"' do
        expect(Commando.config.lookup('help'))
          .to eq(Commando::Action::Help)
      end

      it 'configured "history"' do
        expect(Commando.config.lookup('history'))
          .to eq(Commando::Action::History)
      end

      it 'configured "quit"' do
        expect(Commando.config.lookup('quit'))
          .to eq(Commando::Action::Quit)
      end
    end
  end
end
