require_relative '../../lib/commando/config'

module Commando
  RSpec.describe Config do
    class TestAction1
    end

    class TestAction2
    end

    describe '#lookup' do
      subject { Config.new }

      context 'default actions' do
        it 'configured "help"' do
          expect(subject.lookup('help')).to be_a(Commando::Action::Help)
        end

        it 'configured "history"' do
          expect(subject.lookup('history')).to be_a(Commando::Action::History)
        end

        it 'configured "quit"' do
          expect(subject.lookup('quit')).to be_a(Commando::Action::Quit)
        end
      end

      context 'a registered action' do
        before do
          subject.register('foo', TestAction1, 'test action 1')
        end

        it 'returns the class/instance registered for the action' do
          expect(subject.lookup('foo')).to eq(TestAction1)
        end
      end
    end

    describe '#commands' do
      before do
        subject.register('foo', TestAction1, 'test action 1')
        subject.register('bar', TestAction2, 'test action 2')
      end

      it 'returns each configured action' do
        expect(subject.commands).to include('foo')
        expect(subject.commands).to include('bar')
      end
    end

    describe '.descriptions' do
      subject { Config.new }

      before do
        subject.register('foo', TestAction1, 'test action 1')
        subject.register('bar', TestAction2, 'test action 2')
      end

      it 'descriptions for each configured action' do
        descriptions = subject.descriptions

        expect(descriptions).to have_key('foo')
        expect(descriptions['foo']).to eq('test action 1')
        expect(descriptions).to have_key('bar')
        expect(descriptions['bar']).to eq('test action 2')
      end
    end
  end
end
