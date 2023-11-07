require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a user_id' do
    like = Like.new(user_id: BSON::ObjectId.new)
    expect(like).to be_valid
  end

  it 'is invalid without a user_id' do
    like = Like.new
    expect(like).not_to be_valid
  end

  it 'can be embedded in a post' do
    like = Like.new
    expect(like).to respond_to(:post)
  end

  it 'can be embedded in a comment' do
    like = Like.new
    expect(like).to respond_to(:comment)
  end

  it 'can be embedded in an answer' do
    like = Like.new
    expect(like).to respond_to(:answer)
  end
end
