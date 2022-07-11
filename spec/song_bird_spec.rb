# frozen_string_literal: false

# spec/song_bird_spec.rb
require 'song_bird'

describe SongBird do
  describe '.new' do
    context 'given an empty song bird' do
      it 'it will return correctly' do
        sb = SongBird.new
        expect(sb.class).to eq(SongBird)
      end
    end
  end
end
