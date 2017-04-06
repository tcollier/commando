require_relative '../../../lib/commando/action/quit'

module Commando
  RSpec.describe Action::Quit do
    describe '#perform' do
      it 'raises a QuitException' do
        expect do
          Action::Quit.perform(args: [])
        end.to raise_error(QuitException)
      end
    end
  end
end
