# frozen_string_literal: true

require 'rails_helper'

describe LikeService do
  describe '.get_like' do
    context 'when like exists' do
      it 'returns the like' do
        user_id = 123
        test_like = double('Like', user_id: user_id)
        likeable = double('Likeable', likes: [test_like])

        liked = LikeService.get_like(user_id, likeable)

        expect(likeable).to have_received(:likes).once
        expect(liked).to eq(test_like)
      end
    end

    context 'when like does not exist' do
      it 'returns nil' do
        user_id = 123
        likeable = double('Likeable', likes: [])

        liked = LikeService.get_like(user_id, likeable)

        expect(likeable).to have_received(:likes).once
        expect(liked).to be_nil
      end
    end
  end

end
