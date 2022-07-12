# frozen_string_literal: false

# spec/song_bird_spec.rb
require 'song_bird'

describe SongBird do
  describe '.new' do
    context 'given no parameters' do
      it 'it will return an ArgumentError' do
        expect { SongBird.new }.to raise_error(ArgumentError)
      end
    end

    context 'given an array' do
      it 'it will create a SongBird' do
        sb = SongBird.new([{ file: { action: 'create', name: 'test.txt' } }])
        expect(sb.class).to eq(SongBird)
      end
    end
  end
end
