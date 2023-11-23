# frozen_string_literal: true

require 'rails_helper'

describe LikeService do
  describe '.get_like' do
    context 'when like exists' do
      it 'returns the like' do
        user_id = 123
        test_like = double('Like', user_id: user_id)
        likeable = double('Likeable', likes: double('LikeCollection', find: test_like))

        liked = LikeService.get_like(user_id, likeable)

        expect(likeable.likes).to have_received(:find).with(user_id).once
        expect(liked).to eq(test_like)
      end
    end

    context 'when like does not exist' do
      it 'returns nil' do
        user_id = 123
        likeable = double('Likeable', likes: double('LikeCollection', find: nil))

        liked = LikeService.get_like(user_id, likeable)

        expect(likeable.likes).to have_received(:find).with(user_id).once
        expect(liked).to be_nil
      end
    end
  end

  describe '.like' do
    context 'when like does not exist' do
      it 'creates the like and returns success' do
        user_id = 123
        likeable = double('Likeable', likes: double('LikeCollection', find: nil, create!: true))

        result = LikeService.like(user_id, likeable)

        expect(likeable.likes).to have_received(:find).with(user_id).once
        expect(likeable.likes).to have_received(:create!).with(user_id: user_id).once
        expect(result).to eq({ json: 'Object created', status: :ok })
      end
    end

    context 'when like exists' do
      it 'destroys the like and returns success' do
        user_id = 123
        test_like = double('Like', destroy: true)
        likeable = double('Likeable', likes: [test_like])
        allow(LikeService).to receive(:get_like).and_return(test_like)

        result = LikeService.like(user_id, likeable)

        expect(test_like).to have_received(:destroy).once
        expect(result).to eq({ json: 'Object destroyed', status: :ok })
      end
    end
  end
end
