require_relative '../lib/commando'

RSpec.describe Commando do
  class TestAction1
  end

  class TestAction2
  end

  describe '.commands' do
    it 'returns each configured action' do
      Commando.configure do |config|
        config.register('foo', TestAction1, 'test action 1')
        config.register('bar', TestAction2, 'test action 2')
      end

      expect(Commando.config.commands).to include('foo')
      expect(Commando.config.commands).to include('bar')
    end
  end

  describe '.lookup' do
    it 'looks up a configured action' do
      Commando.configure do |config|
        config.register('foo', TestAction1, 'test action 1')
      end

      expect(Commando.config.lookup('foo')).to eq(TestAction1)
    end
  end

  describe '.each_description' do
    it 'iterates through each configured action' do
      iterated = {}

      Commando.configure do |config|
        config.register('foo', TestAction1, 'test action 1')
        config.register('bar', TestAction2, 'test action 2')
      end

      Commando.config.each_action do |key, value|
        iterated[key] = value
      end

      expect(iterated).to have_key('foo')
      expect(iterated['foo']).to eq('test action 1')
      expect(iterated).to have_key('bar')
      expect(iterated['bar']).to eq('test action 2')
    end
  end
end
