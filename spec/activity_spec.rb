# frozen_string_literal: false

require 'rspec'
require 'activities/activity'

describe Activity do
  context 'when calling log' do
    it 'raises NotImplementedError' do
      expect { Activity.new.log }.to raise_error(NotImplementedError)
    end
  end
  context 'when calling execute' do
    it 'raises NotImplementedError' do
      expect { Activity.new.execute }.to raise_error(NotImplementedError)
    end
  end
  context 'when calling answers?' do
    it 'raises NotImplementedError' do
      expect { Activity.new.answers? 'fred' }.to raise_error(NotImplementedError)
    end
  end
end
