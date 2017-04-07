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

  describe '.descriptions' do
    it 'descriptions for each configured action' do
      Commando.configure do |config|
        config.register('foo', TestAction1, 'test action 1')
        config.register('bar', TestAction2, 'test action 2')
      end

      descriptions = Commando.config.descriptions

      expect(descriptions).to have_key('foo')
      expect(descriptions['foo']).to eq('test action 1')
      expect(descriptions).to have_key('bar')
      expect(descriptions['bar']).to eq('test action 2')
    end
  end
end
